
import 'package:flutter/cupertino.dart';

class PenModel extends ChangeNotifier {

  Color _color = Color(0xff000000);
  double _width = 3;

  get color => _color;
  set setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  get width => _width;
  set setWidth(double width) {
    _width = width;
    notifyListeners();
  }
}