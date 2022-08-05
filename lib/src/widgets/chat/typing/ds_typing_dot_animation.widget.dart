import 'package:flutter/material.dart';

import 'ds_typing_animated_dot.widget.dart';

class DSTypingDotAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final int numberDots;
  final double padding;
  final Duration animationTime;
  final double tweenEndAnimation;

  /// Creates a list of animated dots for use in typing identification and other situations
  ///
  /// To define the stitch appearance use [size] and [color]
  /// Use [numberDots] to set the amount of dots and use [padding] to set the spacing between them
  /// To change the animation speed use [animationTime]
  /// To set the dot ascent level use [upLevelAnimation]
  const DSTypingDotAnimation({
    Key? key,
    this.numberDots = 3,
    this.size = 7,
    this.padding = 3,
    this.animationTime = const Duration(milliseconds: 300),
    required this.color,
    this.tweenEndAnimation = -3,
  }) : super(key: key);

  @override
  State<DSTypingDotAnimation> createState() => _DSTypingDotAnimationState();
}

class _DSTypingDotAnimationState extends State<DSTypingDotAnimation>
    with TickerProviderStateMixin {
  List<AnimationController>? _animationControllers;

  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.numberDots,
        (index) {
          return DsTypingAnimatedDot(
            animationControllers: _animationControllers,
            widget: widget,
            animations: _animations,
            index: index,
          );
        },
      ).toList(),
    );
  }

  /// Controls the animation of the dots
  void _initAnimation() {
    _animationControllers = List.generate(
      widget.numberDots,
      (index) {
        return AnimationController(
          vsync: this,
          duration: widget.animationTime,
        );
      },
    ).toList();

    for (int i = 0; i < widget.numberDots; i++) {
      _animations.add(
        Tween<double>(
          begin: 4,
          end: widget.tweenEndAnimation,
        ).animate(
          _animationControllers![i],
        ),
      );
    }

    for (int i = 0; i < widget.numberDots; i++) {
      _animationControllers![i].addStatusListener(
        (status) {
          if (status == AnimationStatus.forward) {
            if (i != widget.numberDots - 1) {
              Future.delayed(
                const Duration(milliseconds: 120),
              ).then(
                (value) => _animationControllers![i + 1].forward(),
              );
            }
          } else if (status == AnimationStatus.completed) {
            _animationControllers![i].reverse();
          }
          if (i == widget.numberDots - 1 &&
              status == AnimationStatus.dismissed) {
            _animationControllers![0].forward();
          }
        },
      );
    }
    _animationControllers!.first.forward();
  }
}
