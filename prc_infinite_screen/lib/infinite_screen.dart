

import 'package:flutter/material.dart';

class InfiniteScreen extends StatefulWidget {
  InfiniteScreen({Key key}) : super(key: key);
  @override
  _InfiniteScreenState createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen> {
  double _scale = 1.0;
  double _previousScale;
  double x = 0.0;
  double y = 0.0;
  double _preX,_preY;
  Offset _centerOffset;
  double _deltaX, _deltaY;

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
//                        print("preX:${_preX.toString()}, preY:${_preY.toString()}");
                        x = details.focalPoint.dx;
                        y = details.focalPoint.dy;
//                        print("x:${x.toString()}, y:${y.toString()}");
//                        print("localX:${details.localFocalPoint.dx.toString()}, localY:${details.localFocalPoint.dy.toString()}");
//                        print("deltaX:${x - _preX}, deltaY:${y - _preY}");
                        var deltaX = x - _preX;
                        var deltaY = y - _preY;
                        print("deltaX:${deltaX.toString()}, deltaY:${deltaY.toString()}");

                        setState(() {
//                          Offset newOffset = _centerOffset.translate(x - _preX, y - _preY);
                          Offset newOffset = _centerOffset.translate(deltaX, deltaY);
                          print("newOffset: ${newOffset.toString()}");
                          _centerOffset = newOffset;
                          _scale = _previousScale * details.scale;
                        });
                      },
                      onScaleEnd: (details) {
                        _previousScale = null;
                      },
//                    onPanUpdate: (details) {
//                      _preX = x;
//                      _preY = y;
////                        print("preX:${_preX.toString()}, preY:${_preY.toString()}");
//                      x = details.globalPosition.dx;
//                      y = details.globalPosition.dy;
////                        print("x:${x.toString()}, y:${y.toString()}");
//                      print("x - _preX:${x - _preX}, y - _preY:${y - _preY}");
//                      print("deltaX:${details.delta.dx}, deltaY:${details.delta.dy}");
//                      setState(() {
//                        _deltaX = x - _preX;
//                        _deltaY = y - _preY;
//                        Offset newOffset = _centerOffset.translate(_deltaX, _deltaY);
//                        _centerOffset = newOffset;
//                      });
//                    },
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
