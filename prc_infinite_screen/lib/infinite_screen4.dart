import 'package:flutter/material.dart';
import 'package:prc_infinite_screen/sample_flutter_gallery/transformations_demo_gesture_transformable.dart';
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

  Widget _buildInteractiveViewerTwice(Size viewportSize) {
    return ClipRect(
      child: InteractiveViewer(
          transformationController: _controller,
          boundaryMargin: EdgeInsets.symmetric(
              horizontal: viewportSize.width, vertical: viewportSize.height),
          child: Container(
            color: Colors.green,
            child: Stack(
              children: [
                InteractiveViewer(
                    boundaryMargin:
                        EdgeInsets.symmetric(vertical: 1000, horizontal: 1000),
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

  Widget _buildInteractiveViewerAndGestureDetector(Size viewportSize) {
    return ClipRect(
      child: InteractiveViewer(
          transformationController: _controller,
          boundaryMargin: EdgeInsets.symmetric(
              horizontal: viewportSize.width, vertical: viewportSize.height),
          child: Container(
            color: Colors.green,
            child: Stack(
              children: [
                Positioned.fromRect(
                  rect: Rect.fromCenter(
                    center: Offset(_dx, _dy),
                    width: 50,
                    height: 50,
                  ),
                  child: GestureDetector(
                      onScaleUpdate: (details) {
                        setState(() {
                          _dx = details.focalPoint.dx;
                          _dy = details.focalPoint.dy;
                        });
                      },
                      child: Container(
                        color: Colors.blue,
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildGestureTransformableAndOverlay(Size viewportSize) {
    final visibleSize = Size(viewportSize.width * 3, viewportSize.height * 3);
    return ClipRect(
      child: GestureTransformable(
          boundaryRect: Rect.fromLTWH(-visibleSize.width / 3,
              -visibleSize.height / 4, visibleSize.width, visibleSize.height),
          initialTranslation: Offset.zero,
          size: viewportSize,
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

  Widget _buildGestureTransformable(Size viewportSize) {
    final visibleSize = Size(viewportSize.width * 3, viewportSize.height * 3);
    return ClipRect(
      child: GestureTransformable(
          boundaryRect: Rect.fromLTWH(-visibleSize.width / 3,
              -visibleSize.height / 4, visibleSize.width, visibleSize.height),
          initialTranslation: Offset.zero,
          size: viewportSize,
          child: Container(
            color: Colors.green,
            child: Stack(
              children: [
                InteractiveViewer(
                  boundaryMargin:
                      EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
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
            return _buildInteractiveViewerTwice(viewportSize);
//            return _buildInteractiveViewerAndOverlay(viewportSize);
//            return _buildGestureTransformableAndOverlay(viewportSize);
//            return _buildGestureTransformable(viewportSize);
//            return _buildInteractiveViewerAndGestureDetector(viewportSize);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
