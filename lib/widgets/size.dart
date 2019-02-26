import 'dart:math';

import 'package:faltu/listeners/confirmation_listener.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class Size extends StatefulWidget {
  final text;
  final startColor;
  final endColor;
  final isSelected;
  final index;
  final listener;

  Size(this.text, this.startColor, this.endColor, this.isSelected, this.index,
      this.listener);

  @override
  _SizeState createState() => _SizeState();
}

class _SizeState extends State<Size> with TickerProviderStateMixin {
  static var uniqueId = Random().nextInt(1000);


  final GlobalKey _key = GlobalKey(debugLabel: 'key$uniqueId');

  AnimationController _controller;
  Animation<double> _textPaddingAnimation;
  Animation<double> _textPaddingAnimationRev;
  Animation<double> _sizeAnimationRev;
  Animation<double> _dotHeightAnimation;
  Animation<double> _topAnimation;
  Animation<double> _radiusAnimation;
  Animation<Color> _textColorAnimation;

  @override
  void initState() {
    super.initState();
     initialize();
  }

  @override
  void didUpdateWidget(Size oldWidget) {
    super.didUpdateWidget(oldWidget);
    initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get animationStatus => _controller.status == AnimationStatus.completed;

  Animation<double> getTween() {
    var width = 15.0;
    if (_key.currentContext != null) {
      RenderBox box = _key.currentContext.findRenderObject();
      width = box.size.width;
    }
    return Tween<double>(begin: 15.0, end: width).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.listener.success(widget.index);
        animationStatus ? _controller.reverse() : _controller.forward();
      },
      child: AnimatedBuilder(
        animation: _textPaddingAnimation,
        builder: getWidget,
      ),
    );
  }

  Widget getWidget(BuildContext context, Widget child) {
    return Container(
      key: _key,
      height: 30.0,
      decoration: UIHelper.customContainerDecoration(
          Colors.white, Colors.grey, 0.0, 15.0),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: _topAnimation.value,
            left: _topAnimation.value,
            child: Container(
              height: _dotHeightAnimation.value,
              width: getTween().value,
              decoration: UIHelper.customContainerDecoration(
                  widget.endColor, Colors.grey, 0.0, _radiusAnimation.value),
            ),
          ),
          Align(
            alignment: Alignment.center,
            widthFactor: 1.0,
            child: Padding(
              padding: EdgeInsets.only(
                  left: _textPaddingAnimation.value,
                  right: _textPaddingAnimationRev.value),
              child: Text(
                widget.text,
                style:
                    TextStyle(color: _textColorAnimation.value, fontSize: 15.0),
              ),
            ),
          ),
          Positioned(
            right: 7.0,
            top: 7.0,
            child: ScaleTransition(
              scale: _sizeAnimationRev,
              child: Container(
                height: 15.0,
                width: 15.0,
                decoration: UIHelper.customContainerDecoration(
                    Colors.white, Colors.grey, 0.0, 7.0),
                child: Icon(Icons.close, size: 7.0, color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }

  void initialize() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _textPaddingAnimation =
        Tween<double>(begin: 27.0, end: 13.0).animate(_controller);
    _textPaddingAnimationRev =
        Tween<double>(begin: 13.0, end: 27.0).animate(_controller);
    _sizeAnimationRev =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _dotHeightAnimation =
        Tween<double>(begin: 15.0, end: 30.0).animate(_controller);
    _topAnimation = Tween<double>(begin: 7.0, end: 0.0).animate(_controller);
    _radiusAnimation =
        Tween<double>(begin: 7.0, end: 15.0).animate(_controller);
    _textColorAnimation =
        ColorTween(begin: widget.endColor, end: widget.startColor)
            .animate(_controller);
    widget.isSelected ? _controller.forward() : _controller.reverse();
  }
}
