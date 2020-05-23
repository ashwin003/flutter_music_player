import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/models/request_songs.dart';

import '../../screens/songs_page.dart';
import '../controls/custom_grid_tile.dart';

class AlbumTile extends StatelessWidget {
  final AlbumInfo albumInfo;

  const AlbumTile(this.albumInfo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGridTile(
      imagePath: albumInfo.albumArt,
      title: albumInfo.title,
      subtitle: albumInfo.artist,
      id: albumInfo.id,
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    var arguments = RequestSongs(
      albumInfo: albumInfo
    );
    Navigator.of(context).pushNamed(SongsPage.routeName, arguments: arguments);
  }
}