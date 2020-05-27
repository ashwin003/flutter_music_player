import 'dart:ui';
import 'dart:math' as math;
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import 'mini_player.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'expanded_player.dart';

const double playerStartSize = 44;
const double minHeight = 110;
const double playerStartMarginTop = 36;
const double playerEndMarginTop = 80;
const double playerVerticalSpacing = 24;
const double playerHorizontalSpacing = 16;

class BottomSheetContainer extends StatefulWidget {
  @override
  _BottomSheetContainerState createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double get playerEndSize => MediaQuery.of(context).size.height;

  double get maxHeight => MediaQuery.of(context).size.height * 0.85;

  double get headerTopMargin => _lerp(20, 20 + MediaQuery.of(context).padding.top);

  double get headerTopSize => _lerp(14, 24);

  double get playerSize => _lerp(playerStartSize, playerEndSize);

  double get playerTopMargin => _lerp(playerStartMarginTop, playerEndMarginTop + playerVerticalSpacing + playerEndSize + headerTopMargin);

  double get playerLeftMargin => _lerp(playerHorizontalSpacing + playerStartSize, 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, child){
        return Positioned(
          height: _lerp(minHeight, maxHeight),
          left: 0,
          bottom: -5,
          right: 0,
          child: _buildMainContents(ctx)
        );
      },
    );
  }

  GestureDetector _buildMainContents(BuildContext ctx) {
    return GestureDetector(
          onTap: _toggle,
          onVerticalDragUpdate: _handleDragUpdate,
          onVerticalDragEnd: _handleDragEnd,
          child: _buildCard(ctx),
        );
  }

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if(_controller.isAnimating || _controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / maxHeight;
    if(flingVelocity < 0.0) {
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    }
    else if (flingVelocity > 0.0) {
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    }
    else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    }
  }

  double _lerp(double min, double max) => lerpDouble(min, max, _controller.value);

  Card _buildCard(BuildContext context) {
    final double sigmaBlur = 5.0;
    return Card(
      elevation: 99,
      color: Theme.of(context).scaffoldBackgroundColor.withAlpha(150).withOpacity(0.5),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaBlur, sigmaY: sigmaBlur),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: _buildContents()),
          ),
        ),
      )
    );
  }

  List<Widget> _buildContents() {
    var stream = Rx.combineLatest2(
      AudioService.playbackStateStream, 
      AudioService.currentMediaItemStream, 
      (PlaybackState playbackState, MediaItem mediaItem) => Tuple2<PlaybackState, MediaItem>(playbackState, mediaItem))
      .asBroadcastStream();
      
    return [_buildExpandedPlayer(stream), _buildMiniPlayer(stream)];
  }

  Widget _buildMiniPlayer(Stream<Tuple2<PlaybackState, MediaItem>> stream) {
    return AnimatedOpacity(
      opacity: _controller.status == AnimationStatus.completed ? 0 : 1,
      duration: Duration(milliseconds: 200),
      child: MiniPlayer(stream: stream),
    );
  }

  Widget _buildExpandedPlayer(Stream<Tuple2<PlaybackState, MediaItem>> stream) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _controller.status == AnimationStatus.completed ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: ExpandedPlayer(stream: stream),
      ),
    );
  }
}