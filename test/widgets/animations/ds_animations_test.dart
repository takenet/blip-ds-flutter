import 'package:blip_ds/blip_ds.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../extensions/ds_widget_tester.extension.dart';
import 'ds_animation_test.util.dart';

void main() {
  group(
    'Animated Size',
    () {
      testGoldens(
        'Animated size should match golden image',
        (tester) async {
          final builder = DSAnimationTestUtils.createAnimatedSizeScenarios();

          await tester.pumpWidgetBuilder(builder.build());

          await tester.tap(find.byType(DSAnimatedSize));

          await tester.screenMatchesGoldenSteps(
            DSAnimationTestUtils.animatedSizeGoldenPath,
            additionalSteps: 2,
            pumpTotalDuration: const Duration(milliseconds: 60),
          );
        },
      );
    },
  );

  group(
    'Ring Loading',
    () {
      testGoldens(
        'Ring loading should match golden image',
        (tester) async {
          final builder = DSAnimationTestUtils.createRingLoadingScenarios();

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            DSAnimationTestUtils.ringLoadingGoldenPath,
            additionalSteps: 2,
          );
        },
      );
    },
  );

  group(
    'Fading Circle Loading',
    () {
      testGoldens(
        'Fading circle loading should match golden image',
        (tester) async {
          final builder =
              DSAnimationTestUtils.createFadingCircleLoadingScenarios();

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            DSAnimationTestUtils.fadingCircleLoadingGoldenPath,
            additionalSteps: 2,
          );
        },
      );
    },
  );
}
