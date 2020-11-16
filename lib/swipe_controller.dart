import 'package:flutter/material.dart';

class SwipeController extends ChangeNotifier {
  Offset _dragStartOffset = Offset(0, 0);
  Offset _dragUpdateOffset = Offset(0, 0);
  double _direction = 0;

  Offset get dragStartOffset => _dragStartOffset;

  set dragStartOffset(Offset value) {
    _dragStartOffset = value;
    notifyListeners();
  }

  Offset get dragUpdateOffset => _dragUpdateOffset;

  set dragUpdateOffset(Offset value) {
    _dragUpdateOffset = value;
    notifyListeners();
  }

  double get direction => _direction;

  set direction(double value) {
    _direction = value;
    notifyListeners();
  }
}
