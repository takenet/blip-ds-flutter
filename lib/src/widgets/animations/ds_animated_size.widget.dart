import 'package:blip_ds/src/utils/ds_utils.util.dart';
import 'package:flutter/material.dart';

class DSAnimatedSize extends AnimatedSize {
  const DSAnimatedSize({
    super.key,
    super.child,
  }) : super(
          alignment: Alignment.topCenter,
          curve: Curves.linearToEaseOut,
          duration: DSUtils.defaultAnimationDuration,
          clipBehavior: Clip.hardEdge,
        );
}
