import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/services/audio_service.dart';
import 'package:tuple/tuple.dart';

import '../controls/custom_grid_tile.dart';
import '../../screens/albums_page.dart';

class ArtistTile extends StatelessWidget {
  final ArtistInfo artistInfo;
  final ValueSetter<Tuple2<String, dynamic>> actionsHandler;

  const ArtistTile({Key key,@required this.artistInfo, this.actionsHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGridTile(
      imagePath: artistInfo.artistArtPath,
      title: artistInfo.name,
      id: artistInfo.hashCode.toString(),
      subtitle: _prepareSubtitle(artistInfo.numberOfAlbums),
      onTap: () => _onTap(context),
      actionsHandler: _actionsHandler,
    );
  }

  String _prepareSubtitle(String numberOfAlbums) {
    if(int.parse(numberOfAlbums) == 1) {
      return "1 Album";
    }

    return numberOfAlbums + " Albums";
  }

  void _onTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return AlbumsPage(
          audioService: AudioService(),
          artistInfo: artistInfo,
        );
      }
    ));
  }

  void _actionsHandler(String action) {
    if(actionsHandler != null) {
      actionsHandler(Tuple2<String, dynamic>(action, artistInfo.name));
    }
  }
}