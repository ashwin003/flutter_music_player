import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import 'media_controls.dart';
import 'seek_bar.dart';

class ExpandedPlayer extends StatelessWidget {
  final bool isOpen;

  const ExpandedPlayer({Key key, this.isOpen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var stream = Rx.combineLatest2(
            AudioService.playbackStateStream,
            AudioService.currentMediaItemStream,
            (PlaybackState playbackState, MediaItem mediaItem) =>
                Tuple2<PlaybackState, MediaItem>(playbackState, mediaItem))
        .asBroadcastStream();

    return _buildContents(stream);
  }

  Widget _buildContents(Stream<Tuple2<PlaybackState, MediaItem>> stream) {
    return StreamBuilder(
      stream: stream,
      builder: (ctx, AsyncSnapshot<Tuple2<PlaybackState, MediaItem>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.item2 != null) {
            return Column(
              children: [
                _buildMediaControls(snapshot.data.item1),
                _buildSeekBar(
                  snapshot.data.item2,
                  snapshot.data.item1,
                ),
              ],
            );
          }
        }
        return Container();
      },
    );
  }

  Widget _buildMediaControls(PlaybackState playbackState) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..scale(1.5),
      child: MediaControls(
        onNextButtonPressed: AudioService.skipToNext,
        onPlayPauseButtonPressed: AudioService.click,
        onPreviousButtonPressed: AudioService.skipToPrevious,
        isPlaying: playbackState.basicState == BasicPlaybackState.playing,
      ),
    );
  }

  Widget _buildSeekBar(MediaItem mediaItem, PlaybackState playbackState) {
    return mediaItem != null &&
            mediaItem.duration >= playbackState.currentPosition
        ? SeekBar(
            duration: mediaItem.duration,
            currentPosition: playbackState.currentPosition,
          )
        : Container();
  }
}
