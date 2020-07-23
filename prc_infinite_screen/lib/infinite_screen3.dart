import 'package:flutter/material.dart';
import 'sample_flutter_gallery/transformations_demo_gesture_transformable.dart';

class InfiniteScreen3 extends StatefulWidget {
  InfiniteScreen3({Key key}) : super(key: key);
  @override
  _InfiniteScreenState createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen3> {
  double _x = 600;
  double _y = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Infinite Screen3')),
      body: Container(
        child: LayoutBuilder(builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final visibleSize = Size(size.width * 3, size.height * 3);

          return GestureTransformable(
            child: OverflowBox(
              minWidth: 0,
              minHeight: 0,
              maxWidth: visibleSize.width,
              maxHeight: visibleSize.height,
              child: Container(
                color: Colors.red,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Positioned.fromRect(
                        rect: Rect.fromCenter(
                          center: Offset(_x, _y),
                          width: 100,
                          height: 100,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print('TAP !!!!!');
                          },
                          onScaleUpdate: (details) {
                            setState(() {
                              _x = details.focalPoint.dx;
                              _y = details.focalPoint.dy;
                            });
                          },
                          child: Container(color: Colors.grey),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        color: Colors.green,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            boundaryRect: Rect.fromLTWH(-visibleSize.width / 2,
                -visibleSize.height / 2, visibleSize.width, visibleSize.height),
            initialTranslation: Offset(size.width / 2, size.height / 2),
            size: size,
          );
        }),
      ),
    );
  }
}
