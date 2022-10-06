import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

extension DSGoldenToolkitExtension on WidgetTester {
  Future<void> screenMatchesGoldenStages(
    WidgetTester tester,
    String name, {
    required Duration pumpTotalDuration,
    required int stages,
  }) async {
    int duration = 0;
    final int totalDuration = pumpTotalDuration.inMilliseconds;
    final int stageDuration = (totalDuration / stages).floor();

    while (duration <= totalDuration) {
      await screenMatchesGolden(
        tester,
        '${name}_stage_$duration',
        autoHeight: true,
        customPump: (customTester) async {
          await customTester.pump(Duration(milliseconds: duration));
        },
      );

      duration += stageDuration;
    }
  }
}
