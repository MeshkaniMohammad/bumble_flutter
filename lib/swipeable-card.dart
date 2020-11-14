import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class CardContents {
  String imageUrl;
  String name;
  String fruitDescription;
  String age;
}

// class SwipeableCard extends StatefulWidget {
//   final Widget child;
//   final Function onDragStart;
//   final Function onCardOffscreen;
//   SwipeableCard({Key key, this.child, this.onDragStart, this.onCardOffscreen}) : super(key: key);
//
//   @override
//   _SwipeableCardState createState() => _SwipeableCardState();
// }
//
// class _SwipeableCardState extends State<SwipeableCard> with SingleTickerProviderStateMixin {
//   AnimationController cardAnimationController;
//   double direction = 0;
//
//   Offset dragStartOffset = Offset(0, 0);
//   Offset dragUpdateOffset = Offset(0, 0);
//
//   @override
//   void initState() {
//     super.initState();
//     cardAnimationController = AnimationController.unbounded(vsync: this);
//   }
//
//   void _handleNextCardStatusListener() {
//     Size screenSize = MediaQuery.of(context).size;
//     Offset cardOffset = Offset.fromDirection(direction, cardAnimationController.value);
//     if (cardOffset.dx.abs() > screenSize.width || cardOffset.dy.abs() > screenSize.width) {
//       cardAnimationController.stop();
//       cardAnimationController.removeListener(_handleNextCardStatusListener);
//       widget.onCardOffscreen();
//     }
//   }
//
//   bool _hasEscapeVelocity(DragEndDetails dragDetails, Offset dragOffset) {
//     Size screenSize = MediaQuery.of(context).size;
//     return dragOffset.distance.abs() + dragDetails.velocity.pixelsPerSecond.distance.abs() >
//             screenSize.width / 2 &&
//         dragDetails.velocity.pixelsPerSecond.distance > 300;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 16,
//       left: 16,
//       right: 16,
//       bottom: 16,
//       child: AnimatedBuilder(
//           animation: cardAnimationController,
//           builder: (context, snapshot) {
//             return Transform.translate(
//               offset: Offset.fromDirection(direction, cardAnimationController.value),
//               child: GestureDetector(
//                   onPanStart: (DragStartDetails details) {
//                     dragStartOffset = details.globalPosition;
//                     widget.onDragStart();
//                   },
//                   onPanUpdate: (DragUpdateDetails details) {
//                     dragUpdateOffset = details.globalPosition;
//                     Offset dragOffset = dragUpdateOffset - dragStartOffset;
//                     cardAnimationController.value = dragOffset.distance;
//                     direction = dragOffset.direction;
//                   },
//                   onPanEnd: (DragEndDetails deets) {
//                     Offset dragOffset = dragUpdateOffset - dragStartOffset;
//                     if (_hasEscapeVelocity(deets, dragOffset)) {
//                       // if user drags fast enough, simulate with friction simulation
//                       FrictionSimulation frictionSim = FrictionSimulation(1.1,
//                           cardAnimationController.value, deets.velocity.pixelsPerSecond.distance,
//                           tolerance: Tolerance(distance: 1, velocity: 1));
//                       cardAnimationController.animateWith(frictionSim);
//                       cardAnimationController.addListener(_handleNextCardStatusListener);
//                     } else {
//                       // if user doesn't, simulate with spring simulation
//
//                       SpringDescription springDesc = SpringDescription(
//                         mass: 2,
//                         stiffness: 20,
//                         damping: 3,
//                       );
//                       SpringSimulation springSim = SpringSimulation(
//                           springDesc,
//                           cardAnimationController.value,
//                           0,
//                           deets.velocity.pixelsPerSecond.distance);
//                       cardAnimationController.animateWith(springSim);
//                     }
//                   },
//                   child: Container(
//                       child: Card(
//                           clipBehavior: Clip.hardEdge,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                           child: widget.child,
//                           elevation: 3))),
//             );
//           }),
//     );
//   }
// }

class SwipeableCard extends StatefulWidget {
  final Widget child;
  final Function onDragStart;
  final Function onCardOffscreen;
  SwipeableCard({Key key, this.child, this.onDragStart, this.onCardOffscreen}) : super(key: key);

  @override
  _SwipeableCardState createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard> with SingleTickerProviderStateMixin {
  AnimationController cardAnimationController;
  double direction = 0;
  Animation beginTween;
  Offset dragStartOffset = Offset(0, 0);
  Offset dragUpdateOffset = Offset(0, 0);
  bool _startDragging = false;

  @override
  void initState() {
    super.initState();
    cardAnimationController = AnimationController.unbounded(vsync: this);
    // beginTween = MaterialPointArcTween(begin: Offset.zero, end: Offset(1, 0.2))
    beginTween = Tween(begin: 0.0, end: (pi) / 10.0).animate(cardAnimationController)
      ..addListener(() {
        setState(() {});
      });
  }

  void _handleNextCardStatusListener() {
    Size screenSize = MediaQuery.of(context).size;
    Offset cardOffset = Offset.fromDirection(direction, cardAnimationController.value);
    if (cardOffset.dx.abs() > screenSize.width || cardOffset.dy.abs() > screenSize.width) {
      cardAnimationController.stop();
      cardAnimationController.removeListener(_handleNextCardStatusListener);
      widget.onCardOffscreen();
    }
  }

  bool _hasEscapeVelocity(DragEndDetails dragDetails, Offset dragOffset) {
    Size screenSize = MediaQuery.of(context).size;
    return dragOffset.distance.abs() + dragDetails.velocity.pixelsPerSecond.distance.abs() >
            screenSize.width / 2 &&
        dragDetails.velocity.pixelsPerSecond.distance > 300;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      bottom: 16,
      child: AnimatedBuilder(
          animation: cardAnimationController,
          builder: (context, _) {
            return Transform.translate(
              offset: Offset.fromDirection(direction, cardAnimationController.value),
              child: GestureDetector(
                  onHorizontalDragStart: (DragStartDetails details) {
                    _startDragging = true;
                    dragStartOffset = details.globalPosition;
                    widget.onDragStart();
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    if (details.delta.dy < 0 || details.delta.dy > 0) return;
                    dragUpdateOffset = details.globalPosition;
                    Offset dragOffset = dragUpdateOffset - dragStartOffset;
                    cardAnimationController.value = dragOffset.distance;
                    direction = dragOffset.direction;
                  },
                  onHorizontalDragEnd: (DragEndDetails deets) {
                    _startDragging = false;
                    Offset dragOffset = dragUpdateOffset - dragStartOffset;
                    if (_hasEscapeVelocity(deets, dragOffset)) {
                      // if user drags fast enough, simulate with friction simulation
                      FrictionSimulation frictionSim = FrictionSimulation(1.1,
                          cardAnimationController.value, deets.velocity.pixelsPerSecond.distance,
                          tolerance: Tolerance(distance: 1, velocity: 1));
                      cardAnimationController.animateWith(frictionSim);
                      cardAnimationController.addListener(_handleNextCardStatusListener);
                    } else {
                      // if user doesn't, simulate with spring simulation

                      SpringDescription springDesc = SpringDescription(
                        mass: 2,
                        stiffness: 20,
                        damping: 3,
                      );
                      SpringSimulation springSim = SpringSimulation(
                          springDesc,
                          cardAnimationController.value,
                          0,
                          deets.velocity.pixelsPerSecond.distance);
                      cardAnimationController.animateWith(springSim);
                    }
                  },
                  child: Container(
                      child: Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: widget.child,
                          elevation: 3))),
            );
          }),
    );
  }
}