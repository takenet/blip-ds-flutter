import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/widgets/animations/ds_fading_circle_loading.widget.dart';
import 'package:blip_ds/src/widgets/animations/ds_ring_loading.widget.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'mocks/ds_animated_size.mock.dart';

class DSAnimationTestUtils {
  static const animatedSizeGoldenPath = 'ds_animated_size/ds_animated_size';
  static const ringLoadingGoldenPath = 'ds_ring_loading/ds_ring_loading';
  static const fadingCircleLoadingGoldenPath =
      'ds_fading_circle_loading/ds_fading_circle_loading';

  static GoldenBuilder createAnimatedSizeScenarios() {
    final builder = GoldenBuilder.column();

    builder.addScenario(
      'DSAnimatedSize - Size 10 to 30',
      buildAnimatedSize(
        width: 10.0,
        height: 10.0,
      ),
    );

    return builder;
  }

  static GoldenBuilder createRingLoadingScenarios() {
    final builder = GoldenBuilder.column();

    builder.addScenario(
      'DSRingLoading - Blue, Size 24, Line 2',
      buildRingLoading(
        color: DSColors.primaryNight,
        size: 24.0,
        lineWidth: 2.0,
      ),
    );

    builder.addScenario(
      'DSRingLoading - Red, Size 48, Line 4',
      buildRingLoading(
        color: DSColors.extendRedsDragon,
        size: 48.0,
        lineWidth: 5.0,
      ),
    );

    return builder;
  }

  static GoldenBuilder createFadingCircleLoadingScenarios() {
    final builder = GoldenBuilder.column();

    builder.addScenario(
      'DSFadingCircle - Blue, Size 24',
      buildFadingCircleLoading(
        color: DSColors.primaryNight,
        size: 24.0,
      ),
    );

    builder.addScenario(
      'DSFadingCircle - Red, Size 48',
      buildFadingCircleLoading(
        color: DSColors.extendRedsDragon,
        size: 48.0,
      ),
    );

    return builder;
  }

  static MockDSAnimatedSize buildAnimatedSize({
    required final double width,
    required final double height,
  }) {
    return MockDSAnimatedSize(
      initWidth: width,
      initHeight: height,
    );
  }

  static DSRingLoading buildRingLoading({
    final Color color = DSColors.primaryNight,
    final double size = 24.0,
    final double lineWidth = 2.0,
  }) {
    return DSRingLoading(
      color: color,
      size: size,
      lineWidth: lineWidth,
    );
  }

  static DSFadingCircleLoading buildFadingCircleLoading({
    final Color color = DSColors.primaryNight,
    final double size = 24.0,
  }) {
    return DSFadingCircleLoading(
      color: color,
      size: size,
    );
  }
}
