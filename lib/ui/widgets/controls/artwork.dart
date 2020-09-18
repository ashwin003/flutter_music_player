import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../../services/audio_service.dart';

class Artwork extends StatelessWidget {
  final String path;
  final ResourceType resourceType;
  final String resourceId;
  final String id;

  const Artwork({
    Key key,
    this.path,
    this.id,
    this.resourceType,
    this.resourceId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioService = AudioService();
    if (resourceId != null) return _loadImageFromResource(audioService);

    return path == null ? _loadAssetImage() : _loadImageFromPath();
  }

  Widget _loadImageFromResource(AudioService audioService) {
    return FutureBuilder<Uint8List>(
      future: audioService.getArtwork(resourceType, resourceId),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return _loadAssetImage();

        if (snapshot.hasData && snapshot.data.isNotEmpty)
          return Image.memory(snapshot.data);

        return _loadAssetImage();
      },
    );
  }

  Image _loadImageFromPath() =>
      Image.file(File(path.replaceFirst('file:/', '')));

  Image _loadAssetImage() => Image.asset("assets/images/default-backdrop.png");
}
