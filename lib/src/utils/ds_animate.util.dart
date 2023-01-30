import 'package:flutter/material.dart';
import 'ds_utils.util.dart';

/// An animation utility class that has methods related to animations.
abstract class DSAnimate {
  /// Set the position of a scrollable widget using a [ScrollController]
  static Future<void> animateTo(
    ScrollController scrollController, {
    double offset = 0,
    Duration duration = DSUtils.defaultAnimationDuration,
    Curve curve = Curves.easeIn,
  }) async {
    await scrollController.animateTo(
      offset,
      duration: duration,
      curve: curve,
    );
  }
}
