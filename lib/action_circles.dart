import 'package:bumble_flutter/swipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionCircles extends StatefulWidget {
  @override
  _ActionCirclesState createState() => _ActionCirclesState();
}

class _ActionCirclesState extends State<ActionCircles> {
  SwipeController swipeController;

  final double _maxWidth = 120;
  final double _minWidth = 50;
  double _middle;
  double _size = 0;
  double _screenWidth;
  double offset = 0;

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
      offset: Offset(offset, 0),
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(_screenWidth, 0),
            child: Container(
              width: _minWidth,
              decoration: new BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0 - _minWidth, 0),
            child: Container(
              width: _minWidth,
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
      offset = 0;
      return;
    }

    offset = swipeController.dragStartOffset.dx - swipeController.dragUpdateOffset.dx;
  }
}
