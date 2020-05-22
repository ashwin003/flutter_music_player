import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  final Function onPressed;
  final bool isPlaying;

  const PlayPauseButton(this.isPlaying, this.onPressed, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(isPlaying ?? false ? Icons.pause : Icons.play_arrow)
    );
  }
}