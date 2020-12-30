import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prc_infinite_screen/zoom_overlay.dart';

class InfiniteScreen5 extends StatefulWidget {
  InfiniteScreen5({Key key}) : super(key: key);
  @override
  _InfiniteScreenState createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen5> {
  final TransformationController _controller = TransformationController();
  Matrix4 _matrix;
  double _dx = 100;
  double _dy = 100;
  int index = 0;

  Widget _buildInteractiveViewerAndOverlay(Size viewportSize) {
    return ClipRect(
      child: InteractiveViewer(
          transformationController: _controller,
          boundaryMargin: EdgeInsets.symmetric(
              horizontal: viewportSize.width, vertical: viewportSize.height),
          child: Container(
            color: Colors.green,
            child: Stack(
              children: [
                ZoomOverlay(
                    child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                )),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Infinite Screen4')),
      body: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final viewportSize =
                Size(constraints.maxWidth, constraints.maxHeight);
            if (_matrix != null) {
              _matrix = Matrix4.identity()
                ..translate(
                  viewportSize.width / 2,
                  viewportSize.height / 2,
                );
              _controller.value = _matrix;
            }
            return _buildInteractiveViewerAndOverlay(viewportSize);
          },
        ),
      ),
    );
  }
}
