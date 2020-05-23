import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/ui/widgets/controls/artwork.dart';

import '../../services/audio_service.dart';
import '../widgets/grid_list_builder.dart';
import '../widgets/tiles/album_tile.dart';

class AlbumsPage extends StatelessWidget {
  final AudioService audioService;
  static const String routeName = "/artist-albums";

  const AlbumsPage({Key key, this.audioService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var artistInfo = ModalRoute.of(context).settings.arguments as ArtistInfo;
    return Scaffold(
      appBar: AppBar(
        title: _prepareHeader(artistInfo.name),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Artwork(
              id: artistInfo.id,
              path: artistInfo.artistArtPath,
            ),
          ),
        ],
      ),
      body: _buildSongsList(artistInfo.name),
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