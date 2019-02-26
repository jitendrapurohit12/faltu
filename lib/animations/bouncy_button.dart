import 'package:flutter/material.dart';

class BouncyButtonBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  BouncyButtonBuilder(this.animation, this.child);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Container(
              width: animation.value,
              height: getHeight(animation.value),
              child: child,
            );
          },
          child: child),
    );
  }

  double getHeight(double value) {
    if(60.0*(300.0/(value)) < 50)
      return 50;
    else
    return 60.0*(300.0/(value));
  }
}

class WidthAnimationBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  WidthAnimationBuilder(this.animation, this.child);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Container(
              width: animation.value,
              child: child,
            );
          },
          child: child),
    );
  }
}
