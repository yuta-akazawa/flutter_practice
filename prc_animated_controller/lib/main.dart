import 'dart:math';

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
      home: AnimatedController(),
    );
  }
}

class AnimatedController extends StatefulWidget {
  @override
  AnimatedState createState() => AnimatedState();
}

class AnimatedState extends State<AnimatedController> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AnimatedController Demo"),
        ),
        body: Center(
          child: AnimatedContainer(
            width: _width,
            height: _height,
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
            onPressed: () {
              setState(() {
                final random = Random();
                _width = random.nextInt(300).toDouble();
                _height = random.nextInt(300).toDouble();

                _color = Color.fromRGBO(
                    random.nextInt(256),
                    random.nextInt(256),
                    random.nextInt(256),
                    1);
                _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
              });
            }
        ),
      ),
    );
  }
}