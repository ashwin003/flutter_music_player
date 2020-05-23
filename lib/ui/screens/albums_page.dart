import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../services/audio_service.dart';
import '../widgets/grid_list_builder.dart';
import '../widgets/tiles/album_tile.dart';

class AlbumsPage extends StatelessWidget {
  final AudioService audioService;
  static const String routeName = "/artist-albums";

  const AlbumsPage({Key key, this.audioService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var artistName = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: _prepareHeader(artistName),
      ),
      body: _buildSongsList(artistName),
    );
  }

  Widget _prepareHeader(String artistName) {
    if(artistName != null) {
      return Text(artistName);
    }
    return Text('');
  }

  Widget _buildSongsList(String artistName) {
    return GridListBuilder<AlbumInfo>(
      elements: artistName != null ? audioService.getAlbumsFromArtist(artistName) : audioService.getAlbums(),
      builder: (albumInfo) {
        return AlbumTile(albumInfo);
      },
      itemSpacing: EdgeInsets.symmetric(horizontal: 8),
    );
  }
}