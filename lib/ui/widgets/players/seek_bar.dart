import 'dart:math';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../../extensions/durationExtensions.dart';

class SeekBar extends StatelessWidget {
  final int duration;
  final int currentPosition;

  final BehaviorSubject<double> _dragPositionSubject = BehaviorSubject.seeded(null);

  SeekBar({Key key, this.currentPosition, this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = 3 * MediaQuery.of(context).size.width / 4;
    return duration == null ? Container() : _prepareSeekBar(width);
  }

  Widget _prepareSeekBar(double width) {
    return Column(
      children: <Widget>[
        _buildSeekBar(width, currentPosition),
        Row(
          children: <Widget>[
            SizedBox(width: width/8,),
            SizedBox(
              width: width / 2,
              child: Text(Duration(milliseconds: currentPosition).toTimeString(), textAlign: TextAlign.start,),
            ),
            SizedBox(
              width: width / 2,
              child: Text(Duration(milliseconds: duration).toTimeString(), textAlign: TextAlign.end,),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSeekBar(double width, int position) {
    double seekPos;
    var stream = Rx.combineLatest2(
                    _dragPositionSubject.stream, 
                    Stream.periodic(Duration(milliseconds: 200)), 
                    (double dragPosition, _) => dragPosition);
    return StreamBuilder(
      stream: stream,
      builder: (ctx, AsyncSnapshot<double> snapshot) {
        var pos = snapshot.data ?? position.roundToDouble();
        var dur = duration.roundToDouble();
        return SizedBox(
          width: width,
          child: Slider(
            min: 0.0,
            max: dur,
            value: seekPos ?? max(0.0, min(pos, dur)),
            onChanged: (value) {
              _dragPositionSubject.add(value);
            },
            onChangeEnd: (value) {
              AudioService.seekTo(value.toInt());
              seekPos = value;
              _dragPositionSubject.add(null);
            },
          ),
        );
      },
    );
  }
}
