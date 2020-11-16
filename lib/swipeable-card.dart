import 'dart:math';

import 'package:bumble_flutter/swipe_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:provider/provider.dart';

class CardContents {
  String imageUrl;
  String name;
  String fruitDescription;
  String age;
}

class SwappableCard extends StatefulWidget {
  final Widget child;
  final Function onDragStart;
  final Function onCardOffscreen;

  SwappableCard({Key key, this.child, this.onDragStart, this.onCardOffscreen})
      : super(key: key);

  @override
  _SwappableCardState createState() => _SwappableCardState();
}

class _SwappableCardState extends State<SwappableCard>
    with SingleTickerProviderStateMixin {
  AnimationController cardAnimationController;
  SwipeController swipeController;
  Animation beginTween;
  double _angle = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    swipeController = context.read<SwipeController>();
  }

  @override
  void initState() {
    super.initState();
    cardAnimationController = AnimationController.unbounded(vsync: this);
    beginTween =
        Tween(begin: -pi / 14, end: (-pi) / 15).animate(cardAnimationController)
          ..addListener(() {
            setState(() {});
          });
  }

  void _handleNextCardStatusListener() {
    Size screenSize = MediaQuery.of(context).size;
    Offset cardOffset = Offset.fromDirection(
        swipeController.direction, cardAnimationController.value);
    if (cardOffset.dx.abs() > screenSize.width ||
        cardOffset.dy.abs() > screenSize.width) {
      cardAnimationController.stop();
      cardAnimationController.removeListener(_handleNextCardStatusListener);
      widget.onCardOffscreen();
    }
  }

  bool _hasEscapeVelocity(DragEndDetails dragDetails, Offset dragOffset) {
    Size screenSize = MediaQuery.of(context).size;
    return dragOffset.distance.abs() +
                dragDetails.velocity.pixelsPerSecond.distance.abs() >
            screenSize.width / 2 &&
        dragDetails.velocity.pixelsPerSecond.distance > 300;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 5,
      right: 5,
      bottom: 10,
      child: Transform.rotate(
        angle: _angle,
        child: AnimatedBuilder(
          animation: cardAnimationController,
          builder: (context, _) {
            return Transform.translate(
              offset: Offset.fromDirection(
                swipeController.direction,
                cardAnimationController.value,
              ),
              child: GestureDetector(
                onHorizontalDragStart: (DragStartDetails details) {
                  swipeController.dragStartOffset = details.globalPosition;
                  widget.onDragStart();
                },
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  if (details.delta.dx > 0)
                    _angle = (pi / 40);
                  else if (details.delta.dx < 0)
                    _angle = (-pi / 40);
                  else
                    _angle = 0.0;
                  swipeController.dragUpdateOffset = Offset(
                      details.globalPosition.dx,
                      swipeController.dragStartOffset.dy);
                  Offset dragOffset = swipeController.dragUpdateOffset -
                      swipeController.dragStartOffset;
                  cardAnimationController.value = dragOffset.distance;
                  swipeController.direction = dragOffset.direction;
                },
                onHorizontalDragEnd: (DragEndDetails details) {
                  _angle = 0.0;
                  Offset dragOffset = swipeController.dragUpdateOffset -
                      swipeController.dragStartOffset;
                  if (_hasEscapeVelocity(details, dragOffset)) {
                    // if user drags fast enough, simulate with friction simulation
                    FrictionSimulation frictionSim = FrictionSimulation(
                        1.1,
                        cardAnimationController.value,
                        details.velocity.pixelsPerSecond.distance,
                        tolerance: Tolerance(distance: 1, velocity: 1));
                    cardAnimationController.animateWith(frictionSim);
                    cardAnimationController
                        .addListener(_handleNextCardStatusListener);
                  } else {
                    // if user doesn't, simulate with spring simulation

                    SpringDescription springDesc = SpringDescription(
                      mass: 3,
                      stiffness: 1000,
                      damping: 10,
                    );
                    SpringSimulation springSim = SpringSimulation(
                        springDesc,
                        cardAnimationController.value,
                        0,
                        details.velocity.pixelsPerSecond.distance);
                    cardAnimationController.animateWith(springSim);
                  }
                },
                child: Container(
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: widget.child,
                    elevation: 1,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
