import 'package:flutter/material.dart';
import 'package:prc_drawing_app/paper.dart';
import 'package:prc_drawing_app/paper_screen.dart';
import 'package:prc_drawing_app/pen_model.dart';
import 'package:prc_drawing_app/stroke_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (context) => PenModel()),
          ChangeNotifierProvider(create: (context) => StrokeModel())
        ],
      child: MaterialApp(
        home: SafeArea(
          child: PaperScreen(),
        ),
      ),
    );
  }

}
