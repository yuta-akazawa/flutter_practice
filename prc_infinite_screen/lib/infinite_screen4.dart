import 'package:flutter/material.dart';
import 'package:prc_infinite_screen/zoom_overlay.dart';

class InfiniteScreen4 extends StatefulWidget {
  InfiniteScreen4({Key key}) : super(key: key);
  @override
  _InfiniteScreenState createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen4> {
  final TransformationController _controller = TransformationController();
  Matrix4 _matrix;
  double _dx = 100;
  double _dy = 100;
  int index = 0;

  Widget _buildInteractiveViewerAndGestureDetector(Size viewportSize) {
    return ClipRect(
      child: InteractiveViewer(
        transformationController: _controller,
        boundaryMargin: EdgeInsets.symmetric(
          horizontal: viewportSize.width / 2,
          vertical: viewportSize.height / 2,
        ),
        child: Container(
          color: Colors.yellow,
          height: 1000,
          width: 1000,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.green,
                      ),
                      Transform(
                        transform: Matrix4.translationValues(_dx, _dy, 0),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanUpdate: (details) {
                            setState(() {
                              _dx = _dx + details.delta.dx;
                              _dy = _dy + details.delta.dy;
                            });
                            print("blue item: ${details.delta}");
                          },
                          onTap: () {
                            print("blue item TAP");
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final viewportSize =
                Size(constraints.maxWidth, constraints.maxHeight);
            print(viewportSize);
            if (_matrix != null) {
              _matrix = Matrix4.identity()
                ..translate(
                  viewportSize.width,
                  viewportSize.height,
                );
              _controller.value = _matrix;
            }
            // return _buildInteractiveViewerAndGestureDetector(viewportSize);
            return _buildInteractiveViewerAndGestureDetector(viewportSize);
          },
        ),
      ),
    );
  }
}
