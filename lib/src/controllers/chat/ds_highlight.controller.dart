import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DSHighlightController extends GetxController {
  final List<Map<String, AnimationController>> _animations = [];

  void highlight(final String key) {
    Future.delayed(
      const Duration(milliseconds: 600),
      () => _highlight(key),
    );
  }

  AnimationController? getController(final String key) {
    return _animations
        .firstWhereOrNull(
            (element) => element.keys.first.contains(key.toString()))
        ?.values
        .first;
  }

  void add(final String key, final AnimationController controller) =>
      _animations.add(
        {
          key.toString(): controller,
        },
      );

  void _highlight(final String key) {
    var controller = _animations
        .firstWhereOrNull(
            (element) => element.keys.first.contains(key.toString()))
        ?.values
        .first;

    if (controller != null) {
      controller.value = 1;
      Future.delayed(
        Duration(seconds: 2),
        () => controller.value = 0,
      );
    }
  }
}
