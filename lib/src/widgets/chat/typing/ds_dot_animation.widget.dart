import 'package:flutter/material.dart';

import 'ds_animated_dot.widget.dart';

/// Creates a list of animated dots for use in typing identification and other situations
///
/// To define the stitch appearance use [size] and [color]
/// Use [numberDots] to set the amount of dots and use [innerPadding] to set the spacing between them
/// To change the animation speed use [animationTime]
/// To set the dot ascent level use [upLevelAnimation]
class DSDotAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final int numberDots;
  final double innerPadding;
  final Duration animationTime;
  final double upLevelAnimation;

  const DSDotAnimation({
    Key? key,
    this.numberDots = 3,
    this.size = 10,
    this.innerPadding = 3,
    this.animationTime = const Duration(milliseconds: 160),
    required this.color,
    this.upLevelAnimation = -12,
  }) : super(key: key);

  @override
  State<DSDotAnimation> createState() => _DSDotAnimationState();
}

class _DSDotAnimationState extends State<DSDotAnimation>
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.numberDots,
        (index) {
          return DsAnimatedDot(
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
          begin: 0,
          end: widget.upLevelAnimation,
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
