import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audio_service/audio_service.dart' as AS;

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
        return PlaylistTile(
          playlistInfo: playlistInfo,
          actionsHandler: (data) {
            _handleActions(data.item1, data.item2);
          },
        );
      },
      itemSpacing: EdgeInsets.symmetric(horizontal: 8,),
      predicate: (playlistInfo) => playlistInfo.memberIds.isNotEmpty,
    );
  }

  void _handleActions(String action, dynamic identifier) async {
    var songs = await service.getSongsFromPlaylist(identifier as PlaylistInfo);
    AS.AudioService.replaceQueue(songs);
    if('Play' == action) {
      AS.AudioService.playMediaItem(songs.first);
    } else if('Shuffle' == action) {
      AS.AudioService.customAction('shuffle', true);
    }
  }
}