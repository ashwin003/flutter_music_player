import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../mixins/actions_handler.dart';
import '../../ui/widgets/grid_list_builder.dart';
import '../../services/audio_service.dart';
import '../widgets/tiles/artist_tile.dart';

class ArtistsTab extends StatefulWidget {
  @override
  _ArtistsTabState createState() => _ArtistsTabState();
}

class _ArtistsTabState extends State<ArtistsTab> with ActionsHandler {
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
            handleAction(service.getSongsFromArtist(data.item2.toString()), data.item1);
          },
        );
      },
      itemSpacing: EdgeInsets.symmetric(horizontal: 8,),
    );
  }
}