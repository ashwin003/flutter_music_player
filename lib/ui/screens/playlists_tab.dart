import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../mixins/actions_handler.dart';
import '../widgets/grid_list_builder.dart';
import '../../services/audio_service.dart';
import '../widgets/tiles/playlist_tile.dart';

class PlaylistsTab extends StatefulWidget {
  @override
  _PlaylistsTabState createState() => _PlaylistsTabState();
}

class _PlaylistsTabState extends State<PlaylistsTab> with ActionsHandler {
  AudioService service;

  @override
  void initState() {
    super.initState();
    service = AudioService();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      _buildGridList(),
      Positioned(
        bottom: 110,
        right: 24,
        child: _buildFloatingActionButton(),
      )
    ]);
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }

  GridListBuilder<PlaylistInfo> _buildGridList() {
    return GridListBuilder<PlaylistInfo>(
      elements: service.getPlaylists(),
      builder: (playlistInfo) {
        return PlaylistTile(
          playlistInfo: playlistInfo,
          actionsHandler: (data) {
            handleAction(
                service.getSongsFromPlaylist(data.item2 as PlaylistInfo),
                data.item1);
          },
        );
      },
      itemSpacing: EdgeInsets.symmetric(
        horizontal: 8,
      ),
    );
  }
}
