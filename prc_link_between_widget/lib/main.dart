import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: FocusScope(
          autofocus: true,
          child: Focus(
            child: Builder(
              builder: (BuildContext context) {
                final FocusNode focusNode = Focus.of(context);
                final bool hasFocus = focusNode.hasFocus;

                return Stack(
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
                          Offset(x1, y1),
                          Offset(x2, y2)
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print("onTap");
                          if (hasFocus) {
                            focusNode.unfocus();
                          } else {
                            focusNode.requestFocus();
                          }
                        },
                        child: Container(
                          color: hasFocus ? Colors.blue.withOpacity(0.5) : Colors.green.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Positioned.fromRect(
                      rect: Rect.fromPoints(
                          Offset(x1 - 10, y1 - 10),
                          Offset(x1 + 10, y1 + 10)
                      ),
                      child: GestureDetector(
                        onScaleUpdate: (details) {
                          setState(() {
                            x1 = details.focalPoint.dx;
                            y1 = details.focalPoint.dy;
                          });
                          if (hasFocus) {
                            print('scale: hasfocus');
                          } else {
                            print('scale: not hasfocus');
                          }
                        },
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
                            x2 = details.focalPoint.dx;
                            y2 = details.focalPoint.dy;
                          });
                          if (hasFocus) {
                            print('scale: hasfocus');
                          } else {
                            print('scale: not hasfocus');
                          }
                        },
                        child: CircleContainer(color: Colors.blue),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
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