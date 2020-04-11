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
                          Offset(x1 - 5, y1 - 5),
                          Offset(x2 + 5, y2 + 5)
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
                        child: ClipPath(
                          child: Container(
                            color: hasFocus ? Colors.blue.withOpacity(0.5) : Colors.green.withOpacity(0.5),
                          ),
                          clipper: LineClipper(
                              a: Offset(x1, y1),
                              b: Offset(x2, y2),
                          ),
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
                        },
                        child: CircleContainer(
                            color: Colors.red
                        ),
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
                        },
                        child: CircleContainer(
                            color: Colors.yellow
                        ),
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

class LineClipper extends CustomClipper<Path> {
  final Offset a;
  final Offset b;
  LineClipper({
    @required this.a,
    @required this.b
  });

  _clipAroundLine(Path path, Size size) {
    if (a < b || a > b) {
      print("hoge");
      path.lineTo(0, 10);
      path.lineTo(size.width - 10, size.height);
      path.lineTo(size.width, size.height - 10);
      path.lineTo(10, 0);
    } else {
      print("piyo");
      path.moveTo(0, size.height - 10);
      path.lineTo(0, size.height);
      path.lineTo(size.width, 10);
      path.lineTo(size.width, 0);
    }
    if (a.dx == b.dx) {
      print("hogehoge");
      path.lineTo(0, 0);
      path.lineTo(size.width, size.height / 2);
    } else if (a.dy == b.dy) {
      print("figafiga");
    }
  }

  @override
  Path getClip(Size size) {
    final path = Path();
    _clipAroundLine(path, size);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}