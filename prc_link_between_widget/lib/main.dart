
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drag_model.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DragModel(),
      child: MaterialApp(
        title: 'Link Circles',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LinkScreen(),
      ),
    );
  }
}

class LinkScreen extends StatelessWidget  {
  DragModelList

  @override
  Widget build(BuildContext context) {
    final drag1 = Provider.of<DragModel>(context);
    final drag2 = Provider.of<DragModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: LinkPointer(
                offset1: drag1.offset,
                offset2: drag2.offset,
              ),
              child: Container(),
            ),
            DragWidget(
              drag: drag1,
              color: Colors.red,
            ),
            DragWidget(
              drag: drag2,
              color: Colors.green,
            ),
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