import 'package:flutter/material.dart';
import 'play_pause_button.dart';

class MediaControls extends StatelessWidget {

  final Function onPlayPauseButtonPressed;
  final Function onPreviousButtonPressed;
  final Function onNextButtonPressed;
  final bool isPlaying;

  const MediaControls({Key key, this.isPlaying, this.onPlayPauseButtonPressed, this.onPreviousButtonPressed, this.onNextButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: onPreviousButtonPressed,
          icon: Icon(Icons.skip_previous)
        ),
        SizedBox(width: 25,),
        PlayPauseButton(isPlaying, onPlayPauseButtonPressed,),
        SizedBox(width: 25,),
        IconButton(
          onPressed: onNextButtonPressed,
          icon:Icon(Icons.skip_next)
        ),
      ],
    );
  }
}