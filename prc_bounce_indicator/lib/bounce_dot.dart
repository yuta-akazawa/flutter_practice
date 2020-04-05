
import 'package:flutter/material.dart';

class BounceDot extends AnimatedWidget {
  BounceDot({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    print('bounce: ${animation.value}');

    return Transform.translate(
      offset: Offset(0, animation.value),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.yellow
        ),
      ),
    );
  }
}

class BounceDotsIndicator extends StatefulWidget {
  final double beginTweenValue = 0.0;
  final double endTweenValue = 10.0;
  @override
  _BounceDotsIndicatorState createState() => _BounceDotsIndicatorState();
}

class _BounceDotsIndicatorState extends State<BounceDotsIndicator> with TickerProviderStateMixin {
  int numberOfDots = 3;
  List<AnimationController> controllers = List<AnimationController>();
  List<Animation<double>> animations = List<Animation<double>>();
  List<Widget> _widgets = List<Widget>();

  void _addAnimationControllers(){
    controllers.add(AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    ));
  }

  void _addListOfDots(int index) {
    _widgets.add(Padding(
      padding: const EdgeInsets.only(right: 1),
      child: BounceDot(animation: animations[index],),
    ));
  }

  void _buildAnimations(int index) {
    animations.add(
        Tween(
          begin: widget.beginTweenValue,
          end: widget.endTweenValue,
        ).animate(controllers[index])
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              controllers[index].reverse();
            }
            if (index == numberOfDots - 1
                && status == AnimationStatus.dismissed) {
              controllers[0].forward();
            }
            if (animations[index].value > widget.endTweenValue / 4
                && index < numberOfDots - 1) {
              controllers[index + 1].forward();
            }
          })
    );
  }

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < numberOfDots; i++) {
      _addAnimationControllers();
      _buildAnimations(i);
      _addListOfDots(i);
    }
    controllers[0].forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _widgets,
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < numberOfDots; i++) controllers[i].dispose();
    super.dispose();
  }
}
