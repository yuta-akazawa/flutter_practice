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
        child: GestureDetector(
          onTap: () {
            print('TAP!!!!!');
          },
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
                  maxWidth: 300,
                  maxHeight: 300,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
