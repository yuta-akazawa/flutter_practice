import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class TransformWidget extends StatefulWidget {
  final Widget child;
  final Matrix4 matrix;
  const TransformWidget({Key key, @required this.child, @required this.matrix})
      : super(key: key);

  @override
  _TransformWidgetState createState() => _TransformWidgetState();
}

class _TransformWidgetState extends State<TransformWidget> {
  Matrix4 _matrix = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return _matrix != null
        ? Transform(
            transform: (widget.matrix * _matrix),
            child: widget.child,
          )
        : Container();
  }

  void setMatrix(Matrix4 matrix) {
    setState(() {
      _matrix = matrix;
    });
  }
}

class ZoomOverlay extends StatefulWidget {
  final Widget child;
  const ZoomOverlay({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _ZoomOverlayState createState() => _ZoomOverlayState();
}

class _ZoomOverlayState extends State<ZoomOverlay>
    with TickerProviderStateMixin {
  Matrix4 _matrix = Matrix4.identity();
  Offset _startFocalPoint;
  OverlayEntry _overlayEntry;
  bool _isZooming = false;
  Matrix4 _transformMatrix = Matrix4.identity();
  double _x = 100;
  double _y = 100;

  final GlobalKey<_TransformWidgetState> _transformWidget =
      GlobalKey<_TransformWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: Rect.fromCenter(
        center: Offset(_x, _y),
        width: 50,
        height: 50,
      ),
      child: GestureDetector(
        onTap: () {
          print('on tap!!!!!');
        },
        onScaleStart: (details) {
          onScaleStart(details, context);
        },
        onScaleUpdate: onScaleUpdate,
        child: Opacity(
          opacity: _isZooming ? 0 : 1,
          child: widget.child,
        ),
      ),
    );
  }

  void onScaleStart(ScaleStartDetails details, BuildContext context) {
    _startFocalPoint = details.focalPoint;
    _matrix = Matrix4.identity();

    RenderBox renderBox = context.findRenderObject();
    Offset position = renderBox.localToGlobal(Offset.zero);
    _transformMatrix =
        Matrix4.translation(math.Vector3(position.dx, position.dy, 0));

    show(context);

    setState(() {
      _isZooming = true;
    });
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    if (!_isZooming) return;

    Offset translationDelta = details.focalPoint - _startFocalPoint;
    Matrix4 translate = Matrix4.translation(
        math.Vector3(translationDelta.dx, translationDelta.dy, 0));
    RenderBox renderBox = context.findRenderObject();
    Offset focalPoint =
        renderBox.globalToLocal(details.focalPoint - translationDelta);

    var dx = (1 - details.scale) * focalPoint.dx;
    var dy = (1 - details.scale) * focalPoint.dy;

    Matrix4 scale = Matrix4(details.scale, 0, 0, 0, 0, details.scale, 0, 0, 0,
        0, 1, 0, dx, dy, 0, 1);
    _matrix = translate * scale;
    print(details.localFocalPoint);
    setState(() {
      _x = details.localFocalPoint.dx;
      _y = details.localFocalPoint.dy;
    });

    if (_transformWidget != null && _transformWidget.currentState != null) {
      _transformWidget.currentState.setMatrix(_matrix);
    }
  }

  Widget _build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          TransformWidget(
              key: _transformWidget,
              child: widget.child,
              matrix: _transformMatrix),
        ],
      ),
    );
  }

  void show(BuildContext context) {
    if (!_isZooming) {
      OverlayState overlayState = Overlay.of(context);
      _overlayEntry = OverlayEntry(builder: _build);
      overlayState.insert(_overlayEntry);
    }
  }
}
