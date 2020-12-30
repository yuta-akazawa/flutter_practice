import 'package:flutter/material.dart';
import 'package:prc_infinite_screen/infinite_screen4.dart';
import 'package:prc_infinite_screen/infinite_screen5.dart';

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
      home: InfiniteScreen5(),
    );
  }
}
