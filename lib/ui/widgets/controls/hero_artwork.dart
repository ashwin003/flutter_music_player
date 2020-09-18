import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'artwork.dart';

class HeroArtwork extends StatelessWidget {
  final String path;
  final String id;
  final ResourceType resourceType;
  final String resourceId;

  const HeroArtwork({
    Key key,
    this.path,
    this.id,
    this.resourceType,
    this.resourceId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Artwork(
        id: id,
        path: path,
        resourceType: resourceType,
        resourceId: resourceId,
      ),
    );
  }
}
