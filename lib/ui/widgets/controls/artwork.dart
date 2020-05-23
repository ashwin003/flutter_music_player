import 'dart:io';
import 'package:flutter/widgets.dart';

class Artwork extends StatelessWidget {
  final String path;
  final String id;

  const Artwork({Key key, this.path, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return path == null ? _loadAssetImage() : _loadImageFromPath();
  }

  Image _loadImageFromPath() => Image.file(File(path));

  Image _loadAssetImage() => Image.asset("assets/images/default-backdrop.png");
}