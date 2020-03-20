import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Drag(),
    );
  }
}

class Drag extends StatefulWidget {
  Drag({Key key}) : super(key: key);
  @override
  DragState createState() => DragState();
}

class DragState extends State<Drag> {
  double _top = 50;
  double _left = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Draggable(
            child: Container(
              padding: EdgeInsets.only(top: _top, left: _left),
              child: DragItem(),
            ),
            feedback: Container(
              padding: EdgeInsets.only(top: _top, left: _left),
              child: DragItem(),
            ),
            childWhenDragging: Container(
              padding: EdgeInsets.only(top: _top, left: _left),
              child: DragItem(),
            ),
            onDragCompleted: () {},
            onDragEnd: (drag) {
              setState(() {
                _top = _top + drag.offset.dy < 0 ? 0 : _top + drag.offset.dy;
                _left = _left + drag.offset.dx < 0 ? 0 : _left + drag.offset.dx;
              });
            },
          ),
        ),
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
    );
  }
}
