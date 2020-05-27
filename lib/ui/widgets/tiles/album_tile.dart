import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/services/audio_service.dart';
import 'package:tuple/tuple.dart';

import '../../../models/request_songs.dart';
import '../../screens/songs_page.dart';
import '../controls/custom_grid_tile.dart';

class AlbumTile extends StatelessWidget {
  final AlbumInfo albumInfo;
  final ValueSetter<Tuple2<String, dynamic>> actionsHandler;

  const AlbumTile({Key key, @required this.albumInfo, this.actionsHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGridTile(
      imagePath: albumInfo.albumArt,
      title: albumInfo.title,
      subtitle: albumInfo.artist,
      id: albumInfo.hashCode.toString(),
      onTap: () => _onTap(context),
      actionsHandler: _actionsHandler,
    );
  }

  void _onTap(BuildContext context) {
    var arguments = RequestSongs(
      albumInfo: albumInfo
    );
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return SongsPage(
          audioService: AudioService(),
          request: arguments,
        );
      }
    ));
  }

  void _actionsHandler(String action) {
    if(actionsHandler != null) {
      actionsHandler(Tuple2<String, dynamic>(action, albumInfo.id));
    }
  }
}