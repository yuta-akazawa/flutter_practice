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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.green,
          child: Align(
            alignment: const Alignment(1, 1),
            child: SizedBox(
              width: 10,
              height: 20,
              child: OverflowBox(
                minWidth: 0,
                minHeight: 0,
                maxWidth: 100,
                maxHeight: 50,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
