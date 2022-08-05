import 'package:blip_ds/src/widgets/chat/typing/typing_export.dart';
import 'package:flutter/material.dart';

import 'ds_typing_dot.widget.dart';
import 'ds_typing_dot_animation.widget.dart';

/// Animated dot to be included in the dot list
class DsAnimatedDot extends StatelessWidget {
  final List<AnimationController>? _animationControllers;
  final DSTypingDotAnimation widget;
  final List<Animation<double>> _animations;
  final int index;

  const DsAnimatedDot({
    Key? key,
    required List<AnimationController>? animationControllers,
    required this.widget,
    required List<Animation<double>> animations,
    required this.index,
  })  : _animationControllers = animationControllers,
        _animations = animations,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationControllers![index],
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(widget.padding),
          child: Transform.translate(
            offset: Offset(0, _animations[index].value),
            child: DSTypingDot(
              color: widget.color,
              size: widget.size,
            ),
          ),
        );
      },
    );
  }
}
