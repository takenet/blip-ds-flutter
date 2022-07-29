import 'package:flutter/material.dart';

import 'ds_dot.widget.dart';

/// To define the stitch appearance use [size] and [color]
/// Use [numberOfDots] to set the amount of dots and use [innerPadding] to set the spacing between them
/// To change the animation speed use [animationTime]
class DsDotAnimationWidget extends StatefulWidget {
  final double size;
  final Color color;
  final int numberOfDots;
  final double innerPadding;
  final Duration animationTime;

  const DsDotAnimationWidget({
    Key? key,
    this.numberOfDots = 4,
    this.size = 10,
    this.innerPadding = 2.5,
    this.animationTime = const Duration(milliseconds: 200),
    this.color = Colors.black,
  }) : super(key: key);

  @override
  State<DsDotAnimationWidget> createState() => _DsDotAnimationWidget();
}

class _DsDotAnimationWidget extends State<DsDotAnimationWidget>
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
            widget.numberOfDots,
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
      widget.numberOfDots,
      (index) {
        return AnimationController(
          vsync: this,
          duration: widget.animationTime,
        );
      },
    ).toList();

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animations.add(
          Tween<double>(begin: 0, end: -20).animate(_animationControllers![i]));
    }

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animationControllers![i].addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationControllers![i].reverse();
            if (i != widget.numberOfDots - 1) {
              _animationControllers![i + 1].forward();
            }
          }
          if (i == widget.numberOfDots - 1 &&
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
  final DsDotAnimationWidget widget;
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
            child: DotWidget(
              color: widget.color,
              size: widget.size,
            ),
          ),
        );
      },
    );
  }
}
