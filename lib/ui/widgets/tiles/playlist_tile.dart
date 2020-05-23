import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../../models/request_songs.dart';
import '../controls/custom_grid_tile.dart';
import '../../screens/songs_page.dart';

class PlaylistTile extends StatelessWidget {
  final PlaylistInfo playlistInfo;

  const PlaylistTile({Key key, this.playlistInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomGridTile(
      imagePath: null,
      title: playlistInfo.name,
      subtitle: _prepareSubtitle(playlistInfo.memberIds.length),
      id: playlistInfo.id,
      onTap: () => _onTap(context),
    );
  }

  String _prepareSubtitle(int numberOfSongs) {
    if(numberOfSongs == 1) {
      return "1 Song";
    }

    return numberOfSongs.toString() + " Songs";
  }

  void _onTap(BuildContext context) {
    var arguments = RequestSongs(
      playlistInfo: playlistInfo
    );
    Navigator.of(context).pushNamed(SongsPage.routeName, arguments: arguments);
  }
}