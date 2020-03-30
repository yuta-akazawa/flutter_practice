import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draw Scalable Line',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LinkScreen(),
    );
  }
}

class LinkScreen extends StatefulWidget  {
  @override
  LinkState createState() => LinkState();
}

class LinkState extends State<LinkScreen>  {
  double x1 = 10.0;
  double y1 = 10.0;
  double x2 = 100.0;
  double y2 = 100.0;
  double top = 100.0;
  double left = 100.0;
  double _preX1, _preY1, _preX2, _preY2;
  double circleSize = 10.0;
  double right = 100.0;
  double bottom = 100.0;

  @override
  Widget build(BuildContext context) {
//    print("off1: ${Offset(x1, y1)}");
//    print("off2: ${Offset(x2, y2)}");
//    print(top);
    print(left);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: top,
              left: left,
              right: right,
              bottom: bottom,
              child: Container(
                constraints: BoxConstraints.tight(
                  Size(
                      x2 > x1 ? x2 + circleSize : x1 + circleSize,
                      y2 > y1 ? y2 + circleSize : y1 + circleSize
                  ),
                ),
                color: Colors.green,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    CustomPaint(
                      painter: LinkPointer(
                        offset1: Offset(x1, y1),
                        offset2: Offset(x2, y2),
                      ),
                      child: Container(),
                    ),
                    Positioned.fromRect(
                      rect: Rect.fromPoints(
                          Offset(x1 - 10, y1 - 10),
                          Offset(x1 + 10, y1 + 10)
                      ),
                      child: GestureDetector(
                        onScaleStart: (details) {
                          _preX1 = x1;
                          _preY1 = y1;
                          print("pre x :${_preX1.toString()}");
                        },
                        onScaleUpdate: (details) {
                          setState(() {
                            x1 = details.localFocalPoint.dx;
                            y1 = details.localFocalPoint.dy;

                            print("focalPoint.dx: ${details.focalPoint.dx}");
//                            print("focalPoint.dy: ${details.focalPoint.dy}");
                            print("localPoint.dx: ${details.localFocalPoint.dx}");
//                            print("localPoint.dy: ${details.localFocalPoint.dy}");
                            double moveX = _preX1 - details.localFocalPoint.dx;
                            print("moveX: ${moveX.toString()}");
                            left = details.focalPoint.dx;
//                            left += moveX;

//                            if (moveX < 0) {
//                            } else {
//                              left -= details.localFocalPoint.dx;
//                            }
                          });
                        },
//                        onScaleEnd: (details) {
//                          _preX1 = null;
//                          _preY1 = null;
//                        },
                        child: CircleContainer(color: Colors.red),
                      ),
                    ),
                    Positioned.fromRect(
                      rect: Rect.fromPoints(
                          Offset(x2 - 10, y2 - 10),
                          Offset(x2 + 10, y2 + 10)
                      ),
                      child: GestureDetector(
                        onScaleUpdate: (details) {
                          setState(() {
                            x2 = details.localFocalPoint.dx;
                            y2 = details.localFocalPoint.dy;
                          });
                        },
                        child: CircleContainer(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
            color: color,
            width: 5
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
    ..strokeWidth = 2;
    canvas.drawLine(offset1, offset2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}