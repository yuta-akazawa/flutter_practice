import 'package:flutter/material.dart';
import 'package:prc_infinite_screen/zoom_overlay.dart';

class InfiniteScreen4 extends StatefulWidget {
  InfiniteScreen4({Key key}) : super(key: key);
  @override
  _InfiniteScreenState createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen4> {
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
            return ClipRect(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: InteractiveViewer(
                    boundaryMargin: EdgeInsets.symmetric(
                        horizontal: viewportSize.width,
                        vertical: viewportSize.height),
                    child: Container(
                      color: Colors.green,
                      child: Stack(
                        children: [
                          ZoomOverlay(
                              child: Container(
                                color: Colors.blue,
                                width: 50,
                                height: 50,
                              ),
                              twoTouchOnly: false),
                        ],
                      ),
                    )),
              ),
            );
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
