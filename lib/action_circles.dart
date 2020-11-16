import 'dart:math';

import 'package:bumble_flutter/swipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionCircles extends StatefulWidget {
  @override
  _ActionCirclesState createState() => _ActionCirclesState();
}

class _ActionCirclesState extends State<ActionCircles> {
  SwipeController swipeController;
  final double _minWidth = 50;
  double _middle;
  double _scale = 0;
  double _screenWidth;
  double _offset = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    swipeController = context.watch<SwipeController>();
    calculateOffset();
    return Transform.translate(
      offset: Offset(_offset, 0),
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(_screenWidth, 0),
            child: Container(
              width: _minWidth + _scale,
              decoration: new BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0 - _minWidth, 0),
            child: Container(
              width: _minWidth + _scale,
              decoration: new BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void calculateOffset() {
    if (swipeController.dragState != DragState.UPDATE) {
      _offset = 0;
      _scale = 0;
      return;
    }

    //calculate and limit offset to middle of screen
    _offset = max(
      min(
        swipeController.dragStartOffset.dx -
            swipeController.dragUpdateOffset.dx,
        _screenWidth / 2,
      ),
      -_screenWidth / 2 - _minWidth,
    );

    //calculate scale
    _scale = _offset.abs() / 3;
  }
}
