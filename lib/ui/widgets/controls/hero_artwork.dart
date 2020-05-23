import 'package:flutter/widgets.dart';

import 'artwork.dart';

class HeroArtwork extends StatelessWidget {
  final String path;
  final String id;

  const HeroArtwork({Key key, this.path, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Artwork(
        id: id,
        path: path,
      ),
    );
  }
}