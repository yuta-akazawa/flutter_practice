
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _scale = 1.0;
  double _previousScale;
  double x = 0.0;
  double y = 0.0;
  Offset _centerOffset;

  @override
  void initState() {
    super.initState();
    _centerOffset = Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite Screen"),
      ),
      body: Center(
        child: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              final size = Size(constraints.maxWidth, constraints.maxHeight);
              final visibleSize = Size(size.width * 3, size.height * 3);
//              Offset _centerOffset = Offset(x, y);
              print("x:${x.toString()}, y:${y.toString()}");
              return Stack(
                children: <Widget>[
                  Positioned.fromRect(
                    rect: Rect.fromCenter(
                      center: _centerOffset,
                      width: visibleSize.width,
                      height: visibleSize.height
                    ),
                    child: GestureDetector(
//                      onScaleStart: (details) {
//                        _previousScale = _scale;
//                      },
//                      onScaleUpdate: (details) {
//                        x = details.focalPoint.dx;
//                        y = details.focalPoint.dy;
//
//                        Offset newOffset = _centerOffset.translate(-x, -y);
//                        setState(() {
//                          print("_scale:${_scale.toString()}");
////                          if (_scale < 2.0 && _scale > 0.2) {
////                          }
//                            _scale = _previousScale * details.scale;
//                          _centerOffset = newOffset;
//                        });
//                      },
//                      onScaleEnd: (details) {
//                        _previousScale = null;
//                      },
                      onPanUpdate: (details) {
                        Offset newOffset = _centerOffset.translate(details.delta.dx, details.delta.dy);
                        setState(() {
                          _centerOffset = newOffset;
                        });
                      },
                      child: Transform(
                        transform: Matrix4.identity()
                          ..scale(_scale, _scale),
                        alignment: FractionalOffset.center,
                        child: Container(
                          color: Colors.green,
                          child: Center(
                            child: Container(
                              width: 200,
                              height: 200,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
        ),
      ),
    );
  }
}
