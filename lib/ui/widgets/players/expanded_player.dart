import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'seek_bar.dart';
import 'package:tuple/tuple.dart';
import '../controls/artwork.dart';
import 'media_controls.dart';

class ExpandedPlayer extends StatelessWidget {
  final Stream<Tuple2<PlaybackState, MediaItem>> stream;

  const ExpandedPlayer({Key key, this.stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var space = 40.0;
    return SingleChildScrollView(
      child: MediaQuery.of(context).orientation == Orientation.portrait ? 
             _buildPortraitLayout(stream, space) : 
             _buildLandscapeLayout(stream, space),
    );
  }

  Widget _buildPortraitLayout(Stream<Tuple2<PlaybackState, MediaItem>> stream, double space) {
    return StreamBuilder(
      stream: stream,
      builder: (ctx, AsyncSnapshot<Tuple2<PlaybackState, MediaItem>> snapshot) {
        if(snapshot.hasData) {
          var mediaItem = snapshot.data.item2;
          var playbackState = snapshot.data.item1;
          if(mediaItem != null) {
            return Column(
              children: <Widget>[
                Icon(Icons.keyboard_arrow_down),
                SizedBox(height: space,),
                _buildArtwork(1.0, mediaItem.artUri),
                SizedBox(height: space / 2),
                if(mediaItem.duration >= playbackState.currentPosition) SeekBar(duration: mediaItem.duration, currentPosition: playbackState.currentPosition,),
                SizedBox(height: space,),
                ..._prepareTitleSection(ctx, mediaItem),
                SizedBox(height: space,),
                _buildMediaControls(playbackState),
              ],
            );
          }
        }
        return Container();
      },
    );
  }

  Widget _buildLandscapeLayout(Stream<Tuple2<PlaybackState, MediaItem>> stream, double space) {
    return StreamBuilder(
      stream: stream,
      builder: (ctx, AsyncSnapshot<Tuple2<PlaybackState, MediaItem>> snapshot) {
        if(snapshot.hasData) {
          var mediaItem = snapshot.data.item2;
          var playbackState = snapshot.data.item1;
          return Wrap(
            children: <Widget>[
              _buildArtwork(0.75, mediaItem?.artUri),
              SizedBox(height: space,),
              _buildMediaControls(playbackState),
              SizedBox(height: space,),
              ..._prepareTitleSection(ctx, mediaItem)
            ],
          );
        }
        return Container();
      },
    );
  }

  List<Widget> _prepareTitleSection(BuildContext context, MediaItem songInfo) {
    return [
      Text(songInfo?.title ?? 'Select a Song', style: Theme.of(context).textTheme.headline5,),
      SizedBox(height: 15,),
      Text(songInfo?.artist ?? '', style: Theme.of(context).textTheme.subtitle1.copyWith(
        color: Theme.of(context).textTheme.subtitle1.color.withOpacity(0.75)) ,
      ),
    ];
  }

  Widget _buildArtwork(double scaleFactor, String artwork) {
    return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
          ..scale(scaleFactor),
          child: Artwork(path: artwork)
        );
  }

  Widget _buildMediaControls(PlaybackState playbackState) {
    return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
          ..scale(1.5),
          child: MediaControls(
            onNextButtonPressed: AudioService.skipToNext,
            onPlayPauseButtonPressed: AudioService.click,
            onPreviousButtonPressed: AudioService.skipToPrevious,
            isPlaying: playbackState.basicState == BasicPlaybackState.playing,
          ),
        );
  }
}