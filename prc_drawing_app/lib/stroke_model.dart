
import 'package:flutter/cupertino.dart';
import 'package:prc_drawing_app/pen_model.dart';

class StrokeModel extends ChangeNotifier {
  List<Stroke> _strokes = [];

  get all => _strokes;

  void add(PenModel pen, Offset offset) {
    _strokes.add(Stroke(pen.color)..add(offset));
    notifyListeners();
  }

  void update(Offset offset) {
    print("update");
    for(Stroke s in _strokes) {
      print(s.points);
    }
    _strokes.last.add(offset);
    notifyListeners();
  }

  void clear() {
    _strokes = [];
    notifyListeners();
  }

}

class Stroke {
  final List<Offset> points = [];
  final Color color;

  Stroke(this.color);

  add(Offset offset) {
    points.add(offset);
  }
}