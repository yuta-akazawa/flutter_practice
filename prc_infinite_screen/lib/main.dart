
import 'package:flutter/material.dart';
import 'package:prc_infinite_screen/infinite_screen.dart';
import 'package:prc_infinite_screen/infinite_screen2.dart';

import 'sample_flutter_gallery/transformations_demo.dart';

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
      home: InfiniteScreen2(),
//      home: TransformationsDemo(),
    );
  }
}

