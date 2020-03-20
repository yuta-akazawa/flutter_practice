
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'pen_model.dart';
import 'stroke_model.dart';

class Paper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final pen = Provider.of<PenModel>(context);
    final strokes = Provider.of<StrokeModel>(context);

    return Listener(
      onPointerDown: (details) {
        strokes.add(pen, details.position);
      },
      onPointerMove: (details) {
        strokes.update(details.position);
      },
      onPointerUp: (details) {
        strokes.update(details.position);
      },
      child: CustomPaint(
        painter: _Pointer(strokes),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
        ),
      ),
    );
  }
}

class _Pointer extends CustomPainter {
  final StrokeModel strokes;
  _Pointer(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    strokes.all.forEach((stroke) {
      final Paint paint = Paint()
      ..color = stroke.color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
      canvas.drawPoints(PointMode.polygon, stroke.points, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}