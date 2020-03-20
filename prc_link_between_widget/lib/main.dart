import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drag_model.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DragModel()),
        ChangeNotifierProvider(create: (context) => DragItems()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LinkScreen(),
      ),
    );
  }
}

class LinkScreen extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    final dragItems = Provider.of<DragItems>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: LinkPointer(
                offset1: dragItems.list[0].offset,
                offset2: dragItems.list[1].offset,
              ),
              child: Container(),
            ),
            List.generate(dragItems.length, (i) => DragModel());
          ],
        ),
      ),
    );
  }
}

class DragWidget extends StatelessWidget {
  final DragModel drag;
  final Color color;
  DragWidget({this.drag, this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: Rect.fromPoints(
          Offset(drag.dx - 50, drag.dy - 50),
          Offset(drag.dx + 50, drag.dy + 50)
      ),
      child: GestureDetector(
          onScaleUpdate: (details) {
            drag.setOffset(details.focalPoint);
          },
          child: CircleContainer(color: color),
        ),
    );
  }
}

class CircleContainer extends StatelessWidget {
  final Color color;
  CircleContainer({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.identity(),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
            color: color,
            width: 10
        ),
      ),
    );
  }
}

class LinkPointer extends CustomPainter {
  final Offset offset1;
  final Offset offset2;
  LinkPointer({this.offset1, this.offset2});

  @override
  void paint(Canvas canvas, Size size) {
    print("paint size: ${size.width}, ${size.height}");
    final Paint paint= Paint()
    ..color = Colors.blueGrey
    ..strokeWidth = 3;
    canvas.drawLine(offset1, offset2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}