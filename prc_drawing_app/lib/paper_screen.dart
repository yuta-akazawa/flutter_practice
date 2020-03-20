
import 'package:flutter/material.dart';
import 'package:prc_drawing_app/pallete.dart';
import 'package:prc_drawing_app/paper.dart';
import 'package:provider/provider.dart';
import 'stroke_model.dart';

class PaperScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final strokes = Provider.of<StrokeModel>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Paper(),
          Align(
            alignment: Alignment.topLeft,
            child: Pallete(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed:() {
          strokes.clear();
        },

      ),
    );
  }


}