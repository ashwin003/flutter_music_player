import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../../services/audio_service.dart';

class Artwork extends StatefulWidget {
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
  _ArtworkState createState() => _ArtworkState();
}

class _ArtworkState extends State<Artwork> {
  Future<Uint8List> _resourceImage;
  final _audioService = AudioService();

  @override
  void initState() {
    if (widget.resourceId != null) {
      _resourceImage =
          _audioService.getArtwork(widget.resourceType, widget.resourceId);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.resourceId != null) return _loadImageFromResource(_audioService);

    return widget.path == null ? _loadAssetImage() : _loadImageFromPath();
  }

  Widget _loadImageFromResource(AudioService audioService) {
    return FutureBuilder<Uint8List>(
      future: _resourceImage,
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
      Image.file(File(widget.path.replaceFirst('file:/', '')));

  Image _loadAssetImage() => Image.asset("assets/images/default-backdrop.png");
}
