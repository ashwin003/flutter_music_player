import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audio_service/audio_service.dart' as AS;

import '../../ui/widgets/grid_list_builder.dart';
import '../../services/audio_service.dart';
import '../widgets/tiles/artist_tile.dart';

class ArtistsTab extends StatefulWidget {
  @override
  _ArtistsTabState createState() => _ArtistsTabState();
}

class _ArtistsTabState extends State<ArtistsTab> {
  AudioService service;

  @override
  void initState() {
    super.initState();
    service = AudioService();
  }

  @override
  Widget build(BuildContext context) {
    return GridListBuilder<ArtistInfo>(
      elements: service.getArtists(),
      builder: (artistInfo) {
        return ArtistTile(
          artistInfo: artistInfo,
          actionsHandler: (data) {
            _handleActions(data.item1, data.item2);
          },
        );
      },
      itemSpacing: EdgeInsets.symmetric(horizontal: 8,),
    );
  }

  void _handleActions(String action, dynamic identifier) async {
    var songs = await service.getSongsFromArtist(identifier.toString());
    AS.AudioService.replaceQueue(songs);
    if('Play' == action) {
      AS.AudioService.playMediaItem(songs.first);
    } else if('Shuffle' == action) {
      AS.AudioService.customAction('shuffle', true);
    }
  }
}