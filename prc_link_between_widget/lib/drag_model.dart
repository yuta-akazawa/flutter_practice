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

class DragItems extends ChangeNotifier {
  List<DragModel> _list = [];

  get list => _list;
  get length => _list.length;

  void add(DragModel dragModel) {
    _list.add(dragModel);
    notifyListeners();
  }
}