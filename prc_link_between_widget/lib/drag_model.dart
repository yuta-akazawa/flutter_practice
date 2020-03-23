import 'package:flutter/material.dart';

class DragModel extends ChangeNotifier {
  Offset _offset = Offset(300, 700);

  get offset => _offset;
  get dx => _offset.dx;
  get dy => _offset.dy;

  void setOffset(Offset offset) {
    _offset = offset;
    notifyListeners();
  }
}

class DragModelList {
  List list;

  init() {
    list = List.generate(2, (i) => DragModel());
  }
}