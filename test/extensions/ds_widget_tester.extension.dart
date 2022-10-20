import 'package:blip_ds/src/utils/ds_utils.util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

extension DSWidgetTesterExtension on WidgetTester {
  Future<void> screenMatchesGoldenSteps(
    final String name, {
    final int additionalSteps = 0,
    final Duration pumpInitialDuration = Duration.zero,
    final Duration pumpTotalDuration = DSUtils.defaultAnimationDuration,
  }) async {
    if (pumpInitialDuration > pumpTotalDuration) {
      throw Exception(
        'The initial duration shouldn\'t be lower than the total duration.\n'
        '- Initial Duration: $pumpInitialDuration\n'
        '- Total Duration: $pumpTotalDuration',
      );
    }

    int currentDuration = pumpInitialDuration.inMilliseconds;
    final int totalDuration = pumpTotalDuration.inMilliseconds;

    late final int stepDuration;

    if (additionalSteps > 0) {
      stepDuration = (totalDuration / (additionalSteps + 1)).floor();
    } else {
      stepDuration = totalDuration - currentDuration;
    }

    int stepCount = 0;

    while (currentDuration <= totalDuration) {
      await screenMatchesGolden(
        this,
        '${name}_step_$stepCount',
        autoHeight: true,
        customPump: (customTester) async {
          await customTester.pump(
            Duration(milliseconds: currentDuration),
          );
        },
      );

      currentDuration += stepDuration;
      stepCount++;
    }
  }
}
