import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PointState extends ChangeNotifier {
  final _point = List<Offset>();
  UnmodifiableListView<Offset> get points => UnmodifiableListView(_point);

  void add(Offset offset) {
    _point.add(offset);
    notifyListeners();
  }

  void clear() {
    _point.clear();
    notifyListeners();
  }
}

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => PointState(),
    child: MaterialApp(
      title: "Point drawing lesseon",
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: PointerDrawingWidget(title: "Pointer Drawing Lesson"),
    ),
  )
);

class PointerDrawingWidget extends StatelessWidget {
  PointerDrawingWidget({Key key, this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    final pointState = Provider.of<PointState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          pointState.add(details.localPosition);
        },
        child: Consumer<PointState>(
          builder: (BuildContext context, PointState value, Widget _) {
            return CustomPaint(
              painter: MyPainter(value.points),
              child: Center(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: pointState.clear,
        tooltip: 'Clear',
        child: Icon(Icons.clear),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Offset> _points;
  final _rectPaint = Paint()..color = Colors.red;
  MyPainter(this._points);

  @override
  void paint(Canvas canvas, Size size) {
    _points.forEach((offset) => canvas..drawRect(
        Rect.fromCenter(center: offset, width: 40, height: 40),
        _rectPaint
    ));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}