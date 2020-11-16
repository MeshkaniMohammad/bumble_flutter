import 'dart:async';
import 'dart:math';

import 'package:bumble_flutter/providers/swipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionCircles extends StatefulWidget {
  @override
  _ActionCirclesState createState() => _ActionCirclesState();
}

class _ActionCirclesState extends State<ActionCircles> {
  SwipeController swipeController;
  final double _minWidth = 50;
  double _scale = 0;
  double _opacity = 0;
  double _screenWidth;
  double _offset = 0;
  Timer timer;

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
            child: _buildItem(
              color: Colors.yellow[700],
              icon: Icons.done,
            ),
          ),
          Transform.translate(
            offset: Offset(0 - _minWidth, 0),
            child: _buildItem(
              color: Colors.grey[600],
              icon: Icons.close,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    @required Color color,
    @required IconData icon,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1),
      width: _minWidth + _scale,
      decoration: new BoxDecoration(
        color: Colors.white.withOpacity(0.5 + _opacity),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 6),
      ),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  void calculateOffset() {
    if (swipeController.dragState == DragState.START) {
      timer?.cancel();
      _offset = 0;
      _scale = 0;
      _opacity = 0;
      return;
    }

    if (swipeController.dragState == DragState.END) {
      timer = new Timer.periodic(
        Duration(milliseconds: 3),
        (Timer timer) => setState(
          () {
            if (_offset < 1 && _offset > -1) {
              timer.cancel();
              _opacity = 0;
              _offset = 0;
            } else {
              if (_offset > 0)
                _offset -= 1;
              else
                _offset += 1;
              _scale = max(_scale - 1, 0);
            }
          },
        ),
      );

      return;
    }

    double plusExact = _screenWidth / 2;
    double minusExact = -_screenWidth / 2 - _minWidth;

    //calculate and limit offset to middle of screen
    _offset = max(
      min(
        swipeController.dragStartOffset.dx - swipeController.dragUpdateOffset.dx,
        plusExact,
      ),
      minusExact,
    );

    //calculate percent
    double percent;
    if (_offset < 0)
      percent = (_offset / minusExact).abs();
    else
      percent = (_offset / plusExact).abs();

    //calculate scale
    _scale = percent * 80;

    //calculate opacity
    _opacity = min(percent * 0.85, 0.5);
  }
}
