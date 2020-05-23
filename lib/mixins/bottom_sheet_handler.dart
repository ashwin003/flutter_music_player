import 'package:flutter/widgets.dart';
import 'package:flutter_music_player/ui/widgets/players/bottom_sheet_container.dart';

class BottomSheetHandler {
  factory BottomSheetHandler._() => null;

  Widget addBottomSheet({Widget child}) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        child,
        BottomSheetContainer(),
      ],
    );
  }
}