import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../dialogs/songs_dialog.dart';
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
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    showDialog(context: context,
      builder: (ctx) {
        return SongsDialog(
          albumId: albumInfo.id,
          title: albumInfo.title,
        );  
      },
      barrierDismissible: false
    );
  }
}