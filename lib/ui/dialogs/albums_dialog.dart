import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../services/audio_service.dart';
import '../widgets/grid_list_builder.dart';
import '../widgets/tiles/album_tile.dart';

class AlbumsDialog extends StatefulWidget {
  final String artistName;
  final String name;

  const AlbumsDialog({Key key, this.artistName, this.name}) : super(key: key);
  @override
  _AlbumsDialogState createState() => _AlbumsDialogState();
}

class _AlbumsDialogState extends State<AlbumsDialog> {
  AudioService service;

  @override
  void initState() {
    super.initState();
    service = AudioService();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _prepareHeader(),
      ),
      body: _buildSongsList(),
    );
  }

  Widget _prepareHeader() {
    if(widget.artistName != null) {
      return Text(widget.artistName);
    }
    return Text('');
  }

  Widget _buildSongsList() {
    return GridListBuilder<AlbumInfo>(
      elements: widget.artistName != null ? service.getAlbumsFromArtist(widget.artistName) : service.getAlbums(),
      builder: (albumInfo) {
        return AlbumTile(albumInfo);
      },
      itemSpacing: EdgeInsets.symmetric(horizontal: 8),
    );
  }
}