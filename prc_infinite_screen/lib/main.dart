
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
  double _preX,_preY;
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
              return Stack(
                children: <Widget>[
                  Positioned.fromRect(
                    rect: Rect.fromCenter(
                      center: _centerOffset,
                      width: visibleSize.width,
                      height: visibleSize.height
                    ),
                    child: GestureDetector(
                      onScaleStart: (details) {
                        _previousScale = _scale;
                      },
                      onScaleUpdate: (details) {
                        _preX = x;
                        _preY = y;
                        x = details.focalPoint.dx;
                        y = details.focalPoint.dy;
//                        print("x:${x.toString()}, y:${y.toString()}");
//                        print("preX:${_preX.toString()}, preY:${_preY.toString()}");
//                        print("deltaX:${x - _preX}, deltaY:${y - _preY}");
                        Offset newOffset = _centerOffset.translate(x - _preX, y - _preY);

                        setState(() {
                          _centerOffset = newOffset;
//                          print("_scale:${_scale.toString()}");
                            _scale = _previousScale * details.scale;
                        });
                      },
                      onScaleEnd: (details) {
                        _previousScale = null;
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
