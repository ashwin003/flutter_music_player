import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../extensions/audioPlaybackStateExtensions.dart';
import 'media_controls.dart';

class BackgroundPlayer extends BackgroundAudioTask {
  
  AudioPlayer _player = AudioPlayer();
  Completer _completer = Completer();
  List<MediaItem> _queue = new List<MediaItem>();
  MediaItem _currentlyPlaying;
  Duration _position;
  AudioPlaybackState _playbackState;
  bool _repeat;

  MediaItem get _next {
    var index = _queue.indexOf(_currentlyPlaying);
    return index == _queue.length && _repeat == true ? _queue[0] : _queue.elementAt(index + 1);
  }

  bool get _hasNext {
    return _queue.indexOf(_currentlyPlaying) != _queue.length;
  }

  MediaItem get _previous {
    var index = _queue.indexOf(_currentlyPlaying);
    return index == 0 && _repeat == true ? _queue.last : _queue.elementAt(index - 1);
  }

  bool get _hasPrevious {
    return _queue.indexOf(_currentlyPlaying) != 0;
  }

  void playPause() {
    if (AudioServiceBackground.state.basicState == BasicPlaybackState.playing)
      onPause();
    else
      onPlay();
  }

  @override
  Future<dynamic> onCustomAction(String name, dynamic arguments) async {
    if("repeat" == name) {
      _repeat = arguments as bool;
    }
  }

  @override
  Future<void> onStart() async {
    Rx.combineLatest2(_player.getPositionStream(), Stream.periodic(Duration(milliseconds: 500)), (Duration positionStream, _) => positionStream)
    .listen(
      (duration) {
        _position = duration;
        var basicPlaybackState = _playbackState.toBasicPlaybackState();
        AudioServiceBackground.setState(
          basicState: basicPlaybackState, 
          controls: [
            skipToPreviousControl, 
            if(basicPlaybackState == BasicPlaybackState.playing) pauseControl, 
            if(basicPlaybackState == BasicPlaybackState.paused) playControl, 
            skipToNextControl], 
          systemActions: [MediaAction.seekTo],
          updateTime: DateTime.now().millisecondsSinceEpoch,
          position: _position.inMilliseconds,
        );
      });
    _player.playbackStateStream.where((event) => event == AudioPlaybackState.completed).listen((event) {
      onSkipToNext();
     });
    await _completer.future;
  }

  @override
  void onAudioFocusLost() {
    onPause();
  }

  @override
  void onSkipToNext() {
    if(_hasNext) {
      onPlayMediaItem(_next);
    }
  }

  @override  
  void onSkipToPrevious() {
    if(_hasPrevious) {
      onPlayMediaItem(_previous);
    }
  }

  @override
  void onAudioFocusLostTransient() {
    if(_currentlyPlaying != null) {
      onPause();
    }
  }

  @override
  void onAudioFocusGained() {
    if(_currentlyPlaying != null && _playbackState == AudioPlaybackState.playing) {
      onPlay();
    }
  }

  @override
  void onStop() async {
    AudioServiceBackground.setState(
      basicState: BasicPlaybackState.stopped, 
      controls: [], 
      systemActions: []);
    await _player.stop();
    _completer.complete();
    
  }

  @override
  void onPlay() async{
    _playbackState = AudioPlaybackState.playing;
    AudioServiceBackground.setMediaItem(_currentlyPlaying);
    AudioServiceBackground.setQueue(_queue);
    AudioServiceBackground.setState(
      basicState: BasicPlaybackState.playing, 
      controls: [skipToPreviousControl, pauseControl, skipToNextControl], 
      systemActions: [MediaAction.seekTo],
      updateTime: DateTime.now().millisecondsSinceEpoch,
      position: _position.inMilliseconds,
    );
    
    await _player.play();
  }

  @override
  void onPlayMediaItem(MediaItem mediaItem) async {
    _currentlyPlaying = mediaItem;
    await _player.setFilePath(_currentlyPlaying.id);
    onPlay();
  }

  @override
  void onPause() async {
    _playbackState = AudioPlaybackState.paused;
    AudioServiceBackground.setState(
      basicState: BasicPlaybackState.paused, 
      controls: [skipToPreviousControl, playControl, skipToNextControl], 
      systemActions: [MediaAction.seekTo],
      updateTime: DateTime.now().millisecondsSinceEpoch,
      position: _position.inMilliseconds,
    );
    await _player.pause();
  }

  @override
  void onSeekTo(int position) {
    _player.seek(Duration(milliseconds: position));
  }

  @override
  void onClick(MediaButton button) {
    playPause();
  }

  @override
  void onAddQueueItem(MediaItem mediaItem) {
    _queue.add(mediaItem);
  }

  @override
  Future<void> onReplaceQueue(List<MediaItem> queue) async {
    _queue = [...queue];
  }
}