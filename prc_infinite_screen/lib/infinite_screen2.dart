import 'package:flutter/material.dart';
import 'package:prc_infinite_screen/sample_flutter_gallery/transformations_demo_board.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

enum _GestureType {
  translate,
  scale,
  rotate,
}

class InfiniteScreen2 extends StatefulWidget {
  InfiniteScreen2({Key key}) : super(key: key);
  @override
  _InfiniteScreenState createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen2> {
  // The radius of a hexagon tile in pixels.
  static const _kHexagonRadius = 32.0;
  // The margin between hexagons.
  static const _kHexagonMargin = 1.0;
  // The radius of the entire board in hexagons, not including the center.
  static const _kBoardRadius = 12;

  bool _reset = false;
  Board _board = Board(
    boardRadius: _kBoardRadius,
    hexagonRadius: _kHexagonRadius,
    hexagonMargin: _kHexagonMargin,
  );

  @override
  Widget build(BuildContext context) {
    final painter = BoardPainter(
      board: _board,
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite Screen"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        print(size);
        final visibleSize = Size(size.width * 3, size.height * 3);
        print(visibleSize);
        return InfiniteScreenTransformtable(
          child: OverflowBox(
            minWidth: 0,
            minHeight: 0,
            maxWidth: visibleSize.width,
            maxHeight: visibleSize.height,
            child: Container(
              color: Colors.green,
              width: visibleSize.width,
              height: visibleSize.height,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          size: size,
          boundaryRect: Rect.fromLTWH(
              -visibleSize.width / 2,
              -visibleSize.height / 2,
              visibleSize.width,
              visibleSize.height),
//          initialTranslation: Offset(size.width / 2, size.height / 2),
          initialTranslation: Offset.zero,
        );
      }),
    );
  }
}

class InfiniteScreenTransformtable extends StatefulWidget {
  const InfiniteScreenTransformtable({
    Key key,
    @required this.child,
    @required this.size,
    this.boundaryRect,
    this.initialTranslation,
  }) : super(key: key);

  final Widget child;
  final Size size;
  final Rect boundaryRect;
  final Offset initialTranslation;

  @override
  _InfiniteScreenTransformtableState createState() =>
      _InfiniteScreenTransformtableState();
}

class _InfiniteScreenTransformtableState
    extends State<InfiniteScreenTransformtable> {
  Matrix4 _transform = Matrix4.identity();
  _GestureType gestureType;
  Rect _boundaryRect;
  Offset _translateFromScene;

  Matrix4 get _initialTransform {
    var matrix = Matrix4.identity();
    matrix = matrixTranslate(matrix, widget.initialTranslation);
    return matrix;
  }

  static fromViewport(Offset viewPoint, Matrix4 transform) {
    final inverseMatrix = Matrix4.inverted(transform);
    final untransformed =
        inverseMatrix.transform3(Vector3(viewPoint.dx, viewPoint.dy, 0));
    return Offset(untransformed.x, untransformed.y);
  }

  Matrix4 matrixTranslate(Matrix4 matrix, Offset translation) {

    if (translation == Offset.zero) {
      return matrix;
    }
    final scale = _transform.getMaxScaleOnAxis();
    final scaledSize = widget.size / scale;
    final viewportBoundaries = Rect.fromLTRB(
      _boundaryRect.left,
      _boundaryRect.top,
      _boundaryRect.right - scaledSize.width,
      _boundaryRect.bottom - scaledSize.height,
    );
    final translationBoundaries = Rect.fromLTRB(
      -scale * viewportBoundaries.right,
      -scale * viewportBoundaries.bottom,
      -scale * viewportBoundaries.left,
      -scale * viewportBoundaries.top,
    );
    final nextMatrix = matrix.clone()
      ..translate(
        translation.dx,
        translation.dy,
      );
    final nextTranslationVector = nextMatrix.getTranslation();
    final nextTranslation = Offset(
      nextTranslationVector.x,
      nextTranslationVector.y,
    );
    final inBoundaries = translationBoundaries.contains(
      Offset(nextTranslation.dx, nextTranslation.dy),
    );
    if (!inBoundaries) {
      return matrix;
    }

    return nextMatrix;
  }

  void _onScaleStart(ScaleStartDetails details) {
    gestureType = null;
    setState(() {
      _translateFromScene = fromViewport(details.focalPoint, _transform);
    });
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final focalPointScene = fromViewport(
      details.focalPoint,
      _transform,
    );
    if (gestureType == null) {
      if ((details.scale - 1).abs() > details.rotation.abs()) {
        gestureType = _GestureType.scale;
      } else if (details.rotation != 0) {
        gestureType = _GestureType.rotate;
      } else {
        gestureType = _GestureType.translate;
      }
    }
    setState(() {
      if (_translateFromScene != null && details.scale == 1) {
        final translationChange = focalPointScene - _translateFromScene;
        _transform = matrixTranslate(_transform, translationChange);
        _translateFromScene = fromViewport(details.focalPoint, _transform);
      }
    });
  }

  void _onScaleEnd(ScaleEndDetails details) {
    setState(() {
      _translateFromScene = null;
    });

    final velocityTotal = details.velocity.pixelsPerSecond.dx.abs() +
        details.velocity.pixelsPerSecond.dy.abs();
    if (velocityTotal == 0) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _boundaryRect = widget.boundaryRect ?? Offset.zero & widget.size;
    _transform = _initialTransform;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onScaleEnd: _onScaleEnd,
      child: ClipRect(
        child: Transform(
          transform: _transform,
          child: Container(
            child: widget.child,
            height: widget.size.height,
            width: widget.size.width,
          ),
        ),
      ),
    );
  }
}


class BoardPainter extends CustomPainter {
  const BoardPainter({
    this.board,
  });

  final Board board;

  @override
  void paint(Canvas canvas, Size size) {
    void drawBoardPoint(BoardPoint boardPoint) {
      final color = boardPoint.color.withOpacity(
        board.selected == boardPoint ? 0.7 : 1,
      );
      final vertices = board.getVerticesForBoardPoint(boardPoint, color);
      canvas.drawVertices(vertices, BlendMode.color, Paint());
    }

    board.forEach(drawBoardPoint);
  }

  // We should repaint whenever the board changes, such as board.selected.
  @override
  bool shouldRepaint(BoardPainter oldDelegate) {
    return oldDelegate.board != board;
  }
}