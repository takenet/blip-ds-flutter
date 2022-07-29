import 'package:flutter/material.dart';

class DSAnimatedSize extends AnimatedSize {
  const DSAnimatedSize({
    super.key,
    super.child,
  }) : super(
          alignment: Alignment.topCenter,
          curve: Curves.linearToEaseOut,
          duration: const Duration(milliseconds: 300),
          clipBehavior: Clip.hardEdge,
        );
}
