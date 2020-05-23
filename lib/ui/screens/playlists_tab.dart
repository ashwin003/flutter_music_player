import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widgets/grid_list_builder.dart';
import '../../services/audio_service.dart';
import '../widgets/tiles/playlist_tile.dart';

class PlaylistsTab extends StatefulWidget {
  @override
  _PlaylistsTabState createState() => _PlaylistsTabState();
}

class _PlaylistsTabState extends State<PlaylistsTab> {
  AudioService service;

  @override
  void initState() {
    super.initState();
    service = AudioService();
  }
  
  @override
  Widget build(BuildContext context) {
    return GridListBuilder<PlaylistInfo>(
      elements: service.getPlaylists(),
      builder: (playlistInfo) {
        return PlaylistTile(playlistInfo: playlistInfo);
      },
      itemSpacing: EdgeInsets.symmetric(horizontal: 8,),
      predicate: (playlistInfo) => playlistInfo.memberIds.isNotEmpty,
    );
  }
}