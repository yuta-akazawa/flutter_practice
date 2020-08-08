import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class EntireViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZoomOverlay(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
              ),
            ),
            twoTouchOnly: false),
      ),
    );
  }
}

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
  final bool twoTouchOnly;
  const ZoomOverlay({
    Key key,
    @required this.child,
    @required this.twoTouchOnly,
  }) : super(key: key);

  @override
  _ZoomOverlayState createState() => _ZoomOverlayState();
}

class _ZoomOverlayState extends State<ZoomOverlay>
    with TickerProviderStateMixin {
  Matrix4 _matrix = Matrix4.identity();
  Offset _startFocalPoint;
  Animation<Matrix4> _animationReset;
  AnimationController _controllerReset;
  OverlayEntry _overlayEntry;
  bool _isZooming = false;
  int _touchCount = 0;
  Matrix4 _transformMatrix = Matrix4.identity();

  final GlobalKey<_TransformWidgetState> _transformWidget =
      GlobalKey<_TransformWidgetState>();

  @override
  void initState() {
    super.initState();
    _controllerReset =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _controllerReset.addListener(() {
      _transformWidget.currentState.setMatrix(_animationReset.value);
    });
    _controllerReset.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        hide();
      }
    });
  }

  @override
  void dispose() {
    _controllerReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _incrementEnter,
      onPointerUp: _incrementExit,
      child: GestureDetector(
        onScaleStart: (details) {
          onScaleStart(details, context);
        },
        onScaleUpdate: onScaleUpdate,
        onScaleEnd: onScaleEnd,
        child: Opacity(
          opacity: _isZooming ? 0 : 1,
          child: widget.child,
        ),
      ),
    );
  }

  void onScaleStart(ScaleStartDetails details, BuildContext context) {
    if (widget.twoTouchOnly && _touchCount < 2) return;
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

    if (_transformWidget != null && _transformWidget.currentState != null) {
      _transformWidget.currentState.setMatrix(_matrix);
    }
  }

  void onScaleEnd(ScaleEndDetails details) {
    if (!_isZooming) return;

    _animationReset = Matrix4Tween(begin: _matrix, end: Matrix4.identity())
        .animate(_controllerReset);
    _controllerReset.reset();
    _controllerReset.forward();
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

  void hide() async {
    setState(() {
      _isZooming = false;
    });
    _overlayEntry.remove();
    _overlayEntry = null;
  }

  void _incrementEnter(PointerEvent details) {
    _touchCount++;
  }

  void _incrementExit(PointerEvent details) {
    _touchCount--;
  }
}
