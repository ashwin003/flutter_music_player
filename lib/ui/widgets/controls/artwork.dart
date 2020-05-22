import 'dart:io';
import 'package:flutter/widgets.dart';

class Artwork extends StatelessWidget {
  final String path;

  const Artwork({Key key, this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(this.path == null ) {
      return Image.asset("assets/images/default-backdrop.png");
    }
    return Image.file(File(path));
  }
}