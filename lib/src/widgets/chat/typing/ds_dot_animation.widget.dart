import 'package:flutter/material.dart';

import 'ds_dot.widget.dart';

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
    this.size = 7,
    this.innerPadding = 2.5,
    this.animationTime = const Duration(milliseconds: 160),
    required this.color,
    this.upLevelAnimation = -9,
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.numberDots,
            (index) {
              return DotAnimated(
                animationControllers: _animationControllers,
                widget: widget,
                animations: _animations,
                index: index,
              );
            },
          ).toList(),
        ),
      ),
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
      _animations.add(Tween<double>(begin: 0, end: widget.upLevelAnimation)
          .animate(_animationControllers![i]));
    }

    for (int i = 0; i < widget.numberDots; i++) {
      _animationControllers![i].addStatusListener(
        (status) {
          if (status == AnimationStatus.forward) {
            if (i != widget.numberDots - 1) {
              Future.delayed(const Duration(milliseconds: 120))
                  .then((value) => _animationControllers![i + 1].forward());
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

/// Animated dot to be included in the dot list
class DotAnimated extends StatelessWidget {
  const DotAnimated({
    Key? key,
    required List<AnimationController>? animationControllers,
    required this.widget,
    required List<Animation<double>> animations,
    required this.index,
  })  : _animationControllers = animationControllers,
        _animations = animations,
        super(key: key);

  final List<AnimationController>? _animationControllers;
  final DSDotAnimation widget;
  final List<Animation<double>> _animations;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationControllers![index],
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(widget.innerPadding),
          child: Transform.translate(
            offset: Offset(0, _animations[index].value),
            child: DSDot(
              color: widget.color,
              size: widget.size,
            ),
          ),
        );
      },
    );
  }
}
