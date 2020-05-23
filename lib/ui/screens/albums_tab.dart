import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../mixins/album_actions_handler.dart';
import '../widgets/grid_list_builder.dart';
import '../widgets/tiles/album_tile.dart';
import '../../services/audio_service.dart';

class AlbumsTab extends StatefulWidget {
  @override
  _AlbumsTabState createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab> with AlbumActionsHandler {
  AudioService service;

  @override
  void initState() {
    super.initState();
    service = AudioService();
  }
  
  @override
  Widget build(BuildContext context) {
    return GridListBuilder<AlbumInfo>(
      elements: service.getAlbums(),
      builder: (albumInfo) {
        return AlbumTile(
          albumInfo: albumInfo,
          actionsHandler: (data) {
            handleAction(service, data.item1, data.item2);
          },
        );
      },
      itemSpacing: EdgeInsets.symmetric(horizontal: 8),
    );
  }
}