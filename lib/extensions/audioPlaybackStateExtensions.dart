import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

extension AudioPlaybackStateExtensions on AudioPlaybackState {
  BasicPlaybackState toBasicPlaybackState() {
    switch(this) {
      case AudioPlaybackState.playing:
        return BasicPlaybackState.playing;
      case AudioPlaybackState.paused:
        return BasicPlaybackState.paused;
      case AudioPlaybackState.stopped:
        return BasicPlaybackState.stopped;
      case AudioPlaybackState.none:
        return BasicPlaybackState.none;
      case AudioPlaybackState.completed:
        return BasicPlaybackState.stopped;
      case AudioPlaybackState.connecting:
        return BasicPlaybackState.connecting;
      default:
        return BasicPlaybackState.none;
    }
  }
}