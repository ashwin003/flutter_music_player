import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../controls/artwork.dart';
import 'play_pause_button.dart';

class MiniPlayer extends StatelessWidget {
  final Stream<Tuple2<PlaybackState, MediaItem>> stream;

  const MiniPlayer({Key key, this.stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildContents(stream);
  }

  Widget _buildContents(Stream<Tuple2<PlaybackState, MediaItem>> stream) {
    return StreamBuilder(
      stream: stream,
      builder: (ctx, AsyncSnapshot<Tuple2<PlaybackState, MediaItem>> snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data.item2 != null) {
              return _buildMainContents(snapshot.data.item2, snapshot.data.item1);
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
          leading: Artwork(path: songInfo?.artUri,),
          title: Text(songInfo.title),
          subtitle: Text(songInfo.artist),
          trailing: PlayPauseButton(playbackState.basicState == BasicPlaybackState.playing, AudioService.click),
        ),
        LinearProgressIndicator(
          value: playbackState.currentPosition / songInfo.duration ,
        ),
      ],
    );
  }

  ListTile _buildFallbackContents() {
    return ListTile(
      leading: Artwork(path: null, id: 'mini-player',),
      title: Text('Select A Song'),
      subtitle: Text(''),
    );
  }
}