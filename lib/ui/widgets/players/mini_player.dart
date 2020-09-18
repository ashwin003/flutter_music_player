import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../controls/artwork.dart';
import 'play_pause_button.dart';

class MiniPlayer extends StatelessWidget {
  final bool isOpen;

  const MiniPlayer({Key key, this.isOpen}) : super(key: key);

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
            return _buildMainContents(
              snapshot.data.item2,
              snapshot.data.item1,
            );
          }
        }
        return _buildFallbackContents();
      },
    );
  }

  Widget _buildMainContents(MediaItem songInfo, PlaybackState playbackState) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Artwork(
            path: songInfo?.artUri,
            resourceType: ResourceType.SONG,
            resourceId: songInfo.extras['id'],
            key: ValueKey(songInfo.extras['id']),
          ),
          title: Text(songInfo.title),
          subtitle: Text(songInfo.artist),
          trailing: isOpen ? null : _buildPlayPauseButton(playbackState),
        ),
        _buildLinearProgressIndicator(
          playbackState,
          songInfo,
        ),
      ],
    );
  }

  Widget _buildLinearProgressIndicator(
      PlaybackState playbackState, MediaItem songInfo) {
    return isOpen
        ? null
        : LinearProgressIndicator(
            value: playbackState.currentPosition / songInfo.duration,
          );
  }

  Widget _buildPlayPauseButton(PlaybackState playbackState) {
    return PlayPauseButton(
      playbackState.basicState == BasicPlaybackState.playing,
      AudioService.click,
    );
  }

  ListTile _buildFallbackContents() {
    return ListTile(
      leading: Artwork(
        path: null,
        id: 'mini-player',
      ),
      title: Text('Select A Song'),
      subtitle: Text(''),
    );
  }
}
