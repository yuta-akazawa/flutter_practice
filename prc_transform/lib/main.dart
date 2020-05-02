import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart' hide Colors;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perspective',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  var yOffset = 400.0;
  var xOffset = 200.0;
  var rotation = 0.0;
  var lastRotation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geature Scale'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fromRect(
            rect: Rect.fromPoints(
              Offset(xOffset - 250, yOffset - 100),
              Offset(xOffset + 250, yOffset + 100),
            ),
            child: GestureDetector(
              onScaleStart: (details) {
                _previousScale = _scale;
                lastRotation = rotation;
              },
              onScaleUpdate: (details) {
                xOffset = details.focalPoint.dx;
                yOffset = details.focalPoint.dy;
                print("x:${xOffset.toString()}, y:${yOffset.toString()}");

                lastRotation += details.rotation;
                rotation = lastRotation - details.rotation;
                setState(() {
                  _scale = _previousScale * details.scale;
                });
              },
              onScaleEnd: (details) {
                _previousScale = null;
                lastRotation = rotation;
              },
              child: Transform(
                transform: Matrix4.identity()
                  ..rotateZ(rotation * pi / 180.0)
                  ..scale(_scale, _scale),
                alignment: FractionalOffset.center,
                child: Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
