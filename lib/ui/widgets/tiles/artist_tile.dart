import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../controls/custom_grid_tile.dart';
import '../../screens/albums_page.dart';

class ArtistTile extends StatelessWidget {
  final ArtistInfo artistInfo;

  const ArtistTile(this.artistInfo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGridTile(
      imagePath: artistInfo.artistArtPath,
      title: artistInfo.name,
      id: artistInfo.id,
      subtitle: _prepareSubtitle(artistInfo.numberOfAlbums),
      onTap: () => _onTap(context),
    );
  }

  String _prepareSubtitle(String numberOfAlbums) {
    if(int.parse(numberOfAlbums) == 1) {
      return "1 Album";
    }

    return numberOfAlbums + " Albums";
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed(AlbumsPage.routeName, arguments: artistInfo);
  }
}