import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/buttons/ds_pause_button.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_play_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../extensions/ds_widget_tester.extension.dart';
import 'ds_buttons_test.util.dart';

void main() {
  group(
    'Standard Button',
    () {
      testGoldens(
        'Standard button should match golden image when is enabled',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSButton',
            'Enabled',
            buttonBuilder: DSButtonsTestUtils.buildStandardButton,
            isEnabled: true,
            isLoading: false,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.enabledStandardButtonGoldenPath}/ds_button_enabled',
            autoHeight: true,
          );
        },
      );

      testGoldens(
        'Standard button should match golden image when is disabled',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSButton',
            'Disabled',
            buttonBuilder: DSButtonsTestUtils.buildStandardButton,
            isEnabled: false,
            isLoading: false,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.disabledStandardButtonGoldenPath}/ds_button_disabled',
            autoHeight: true,
          );
        },
      );

      testGoldens(
        'Standard button should match golden image when is enabled and loading',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSButton',
            'Enabled + Loading',
            buttonBuilder: DSButtonsTestUtils.buildStandardButton,
            isEnabled: true,
            isLoading: true,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            '${DSButtonsTestUtils.enabledStandardButtonGoldenPath}/loading/ds_button_enabled_loading',
            additionalSteps: 2,
          );
        },
      );

      testGoldens(
        'Standard button should match golden image when is disabled and loading',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSButton',
            'Disabled + Loading',
            buttonBuilder: DSButtonsTestUtils.buildStandardButton,
            isEnabled: false,
            isLoading: true,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            '${DSButtonsTestUtils.disabledStandardButtonGoldenPath}/loading/ds_button_disabled_loading',
            additionalSteps: 2,
          );
        },
      );

      testWidgets(
        'Standard button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSButton button = DSButtonsTestUtils.buildStandardButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidgetBuilder(button);

          expect(wasTapped, false);

          await tester.tap(
            find.byWidget(button),
          );

          expect(wasTapped, true);
        },
      );

      testWidgets(
        'Standard button should be disabled',
        (tester) async {
          const Key keyButton1 = Key('button-1');
          const Key keyButton2 = Key('button-2');
          const Key keyButton3 = Key('button-3');
          const Key keyButton4 = Key('button-4');

          int counter = 0;
          incrementCounter() => counter++;

          final Widget buttons = Column(
            children: [
              DSButtonsTestUtils.buildStandardButton(
                key: keyButton1,
                onPressed: null,
                isEnabled: false,
              ),
              DSButtonsTestUtils.buildStandardButton(
                key: keyButton2,
                onPressed: null,
                isEnabled: true,
              ),
              DSButtonsTestUtils.buildStandardButton(
                key: keyButton3,
                onPressed: incrementCounter,
                isEnabled: false,
              ),
              DSButtonsTestUtils.buildStandardButton(
                key: keyButton4,
                onPressed: incrementCounter,
                isEnabled: true,
              ),
            ],
          );

          await tester.pumpWidgetBuilder(buttons);

          final Finder findButton1 = find.byKey(keyButton1);
          final Finder findButton2 = find.byKey(keyButton2);
          final Finder findButton3 = find.byKey(keyButton3);
          final Finder findButton4 = find.byKey(keyButton4);

          await tester.tap(findButton1);
          await tester.tap(findButton2);
          await tester.tap(findButton3);

          expect(counter, 0);

          await tester.tap(findButton4);

          expect(counter, 1);
        },
      );
    },
  );

  group(
    'Primary Button',
    () {
      testGoldens(
        'Primary button should match golden image when is enabled',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSPrimaryButton',
            'Enabled',
            buttonBuilder: DSButtonsTestUtils.buildPrimaryButton,
            isEnabled: true,
            isLoading: false,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.enabledPrimaryButtonGoldenPath}/ds_primary_button_enabled',
            autoHeight: true,
          );
        },
      );

      testGoldens(
        'Primary button should match golden image when is disabled',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSPrimaryButton',
            'Disabled',
            buttonBuilder: DSButtonsTestUtils.buildPrimaryButton,
            isEnabled: false,
            isLoading: false,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.disabledPrimaryButtonGoldenPath}/ds_primary_button_disabled',
            autoHeight: true,
          );
        },
      );

      testGoldens(
        'Primary button should match golden image when is enabled and loading',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSPrimaryButton',
            'Enabled + Loading',
            buttonBuilder: DSButtonsTestUtils.buildPrimaryButton,
            isEnabled: true,
            isLoading: true,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            '${DSButtonsTestUtils.enabledPrimaryButtonGoldenPath}/loading/ds_primary_button_enabled_loading',
            additionalSteps: 2,
          );
        },
      );

      testGoldens(
        'Primary button should match golden image when is disabled and loading',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSPrimaryButton',
            'Disabled + Loading',
            buttonBuilder: DSButtonsTestUtils.buildPrimaryButton,
            isEnabled: false,
            isLoading: true,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            '${DSButtonsTestUtils.disabledPrimaryButtonGoldenPath}/loading/ds_primary_button_disabled_loading',
            additionalSteps: 2,
          );
        },
      );

      testWidgets(
        'Primary button should be a standard button subclass',
        (tester) async {
          final DSPrimaryButton button = DSButtonsTestUtils.buildPrimaryButton(
            onPressed: () {},
          );

          await tester.pumpWidgetBuilder(button);

          final Finder findButton = find.bySubtype<DSButton>();

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Primary button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSButton button = DSButtonsTestUtils.buildPrimaryButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidgetBuilder(button);

          expect(wasTapped, false);

          await tester.tap(
            find.byWidget(button),
          );

          expect(wasTapped, true);
        },
      );

      testWidgets(
        'Primary button should be disabled',
        (tester) async {
          const Key keyButton1 = Key('button-1');
          const Key keyButton2 = Key('button-2');
          const Key keyButton3 = Key('button-3');
          const Key keyButton4 = Key('button-4');

          int counter = 0;
          incrementCounter() => counter++;

          final Widget buttons = Column(
            children: [
              DSButtonsTestUtils.buildPrimaryButton(
                key: keyButton1,
                onPressed: null,
                isEnabled: false,
              ),
              DSButtonsTestUtils.buildPrimaryButton(
                key: keyButton2,
                onPressed: null,
                isEnabled: true,
              ),
              DSButtonsTestUtils.buildPrimaryButton(
                key: keyButton3,
                onPressed: incrementCounter,
                isEnabled: false,
              ),
              DSButtonsTestUtils.buildPrimaryButton(
                key: keyButton4,
                onPressed: incrementCounter,
                isEnabled: true,
              ),
            ],
          );

          await tester.pumpWidgetBuilder(buttons);

          final Finder findButton1 = find.byKey(keyButton1);
          final Finder findButton2 = find.byKey(keyButton2);
          final Finder findButton3 = find.byKey(keyButton3);
          final Finder findButton4 = find.byKey(keyButton4);

          await tester.tap(findButton1);
          await tester.tap(findButton2);
          await tester.tap(findButton3);

          expect(counter, 0);

          await tester.tap(findButton4);

          expect(counter, 1);
        },
      );
    },
  );

  group(
    'Secondary Button',
    () {
      testGoldens(
        'Secondary button should match golden image when is enabled',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSSecondaryButton',
            'Enabled',
            buttonBuilder: DSButtonsTestUtils.buildSecondaryButton,
            isEnabled: true,
            isLoading: false,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.enabledSecondaryButtonGoldenPath}/ds_secondary_button_enabled',
            autoHeight: true,
          );
        },
      );

      testGoldens(
        'Secondary button should match golden image when is disabled',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSSecondaryButton',
            'Disabled',
            buttonBuilder: DSButtonsTestUtils.buildSecondaryButton,
            isEnabled: false,
            isLoading: false,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.disabledSecondaryButtonGoldenPath}/ds_secondary_button_disabled',
            autoHeight: true,
          );
        },
      );

      testGoldens(
        'Secondary button should match golden image when is enabled and loading',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSSecondaryButton',
            'Enabled + Loading',
            buttonBuilder: DSButtonsTestUtils.buildSecondaryButton,
            isEnabled: true,
            isLoading: true,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            '${DSButtonsTestUtils.enabledSecondaryButtonGoldenPath}/loading/ds_secondary_button_enabled_loading',
            additionalSteps: 2,
          );
        },
      );

      testGoldens(
        'Secondary button should match golden image when is disabled and loading',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSSecondaryButton',
            'Disabled + Loading',
            buttonBuilder: DSButtonsTestUtils.buildSecondaryButton,
            isEnabled: false,
            isLoading: true,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            '${DSButtonsTestUtils.disabledSecondaryButtonGoldenPath}/loading/ds_secondary_button_disabled_loading',
            additionalSteps: 2,
          );
        },
      );

      testWidgets(
        'Secondary button should be a standard button subclass',
        (tester) async {
          final DSSecondaryButton button =
              DSButtonsTestUtils.buildSecondaryButton(
            onPressed: () {},
          );

          await tester.pumpWidgetBuilder(button);

          final Finder findButton = find.bySubtype<DSButton>();

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Secondary button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSButton button = DSButtonsTestUtils.buildSecondaryButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidgetBuilder(button);

          expect(wasTapped, false);

          await tester.tap(
            find.byWidget(button),
          );

          expect(wasTapped, true);
        },
      );

      testWidgets(
        'Secondary button should be disabled',
        (tester) async {
          const Key keyButton1 = Key('button-1');
          const Key keyButton2 = Key('button-2');
          const Key keyButton3 = Key('button-3');
          const Key keyButton4 = Key('button-4');

          int counter = 0;
          incrementCounter() => counter++;

          final Widget buttons = Column(
            children: [
              DSButtonsTestUtils.buildSecondaryButton(
                key: keyButton1,
                onPressed: null,
                isEnabled: false,
              ),
              DSButtonsTestUtils.buildSecondaryButton(
                key: keyButton2,
                onPressed: null,
                isEnabled: true,
              ),
              DSButtonsTestUtils.buildSecondaryButton(
                key: keyButton3,
                onPressed: incrementCounter,
                isEnabled: false,
              ),
              DSButtonsTestUtils.buildSecondaryButton(
                key: keyButton4,
                onPressed: incrementCounter,
                isEnabled: true,
              ),
            ],
          );

          await tester.pumpWidgetBuilder(buttons);

          final Finder findButton1 = find.byKey(keyButton1);
          final Finder findButton2 = find.byKey(keyButton2);
          final Finder findButton3 = find.byKey(keyButton3);
          final Finder findButton4 = find.byKey(keyButton4);

          await tester.tap(findButton1);
          await tester.tap(findButton2);
          await tester.tap(findButton3);

          expect(counter, 0);

          await tester.tap(findButton4);

          expect(counter, 1);
        },
      );
    },
  );

  group(
    'Tertiary Button',
    () {
      testGoldens(
        'Tertiary button should match golden image when is enabled',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSTertiaryButton',
            'Enabled',
            buttonBuilder: DSButtonsTestUtils.buildTertiaryButton,
            isEnabled: true,
            isLoading: false,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.enabledTertiaryButtonGoldenPath}/ds_tertiary_button_enabled',
            autoHeight: true,
          );
        },
      );

      testGoldens(
        'Tertiary button should match golden image when is disabled',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSTertiaryButton',
            'Disabled',
            buttonBuilder: DSButtonsTestUtils.buildTertiaryButton,
            isEnabled: false,
            isLoading: false,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.disabledTertiaryButtonGoldenPath}/ds_tertiary_button_disabled',
            autoHeight: true,
          );
        },
      );

      testGoldens(
        'Tertiary button should match golden image when is enabled and loading',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSTertiaryButton',
            'Enabled + Loading',
            buttonBuilder: DSButtonsTestUtils.buildTertiaryButton,
            isEnabled: true,
            isLoading: true,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            '${DSButtonsTestUtils.enabledTertiaryButtonGoldenPath}/loading/ds_tertiary_button_enabled_loading',
            additionalSteps: 2,
          );
        },
      );

      testGoldens(
        'Tertiary button should match golden image when is disabled and loading',
        (tester) async {
          final builder = DSButtonsTestUtils.createButtonScenarios(
            'DSTertiaryButton',
            'Disabled + Loading',
            buttonBuilder: DSButtonsTestUtils.buildTertiaryButton,
            isEnabled: false,
            isLoading: true,
          );

          await tester.pumpWidgetBuilder(builder.build());

          await tester.screenMatchesGoldenSteps(
            '${DSButtonsTestUtils.disabledTertiaryButtonGoldenPath}/loading/ds_tertiary_button_disabled_loading',
            additionalSteps: 2,
          );
        },
      );

      testWidgets(
        'Tertiary button should be a standard button subclass',
        (tester) async {
          final DSTertiaryButton button =
              DSButtonsTestUtils.buildTertiaryButton(
            onPressed: () {},
          );

          await tester.pumpWidgetBuilder(button);

          final Finder findButton = find.bySubtype<DSButton>();

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Tertiary button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSButton button = DSButtonsTestUtils.buildTertiaryButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidgetBuilder(button);

          expect(wasTapped, false);

          await tester.tap(
            find.byWidget(button),
          );

          expect(wasTapped, true);
        },
      );

      testWidgets(
        'Tertiary button should be disabled',
        (tester) async {
          const Key keyButton1 = Key('button-1');
          const Key keyButton2 = Key('button-2');
          const Key keyButton3 = Key('button-3');
          const Key keyButton4 = Key('button-4');

          int counter = 0;
          incrementCounter() => counter++;

          final Widget buttons = Column(
            children: [
              DSButtonsTestUtils.buildTertiaryButton(
                key: keyButton1,
                onPressed: null,
                isEnabled: false,
              ),
              DSButtonsTestUtils.buildTertiaryButton(
                key: keyButton2,
                onPressed: null,
                isEnabled: true,
              ),
              DSButtonsTestUtils.buildTertiaryButton(
                key: keyButton3,
                onPressed: incrementCounter,
                isEnabled: false,
              ),
              DSButtonsTestUtils.buildTertiaryButton(
                key: keyButton4,
                onPressed: incrementCounter,
                isEnabled: true,
              ),
            ],
          );

          await tester.pumpWidgetBuilder(buttons);

          final Finder findButton1 = find.byKey(keyButton1);
          final Finder findButton2 = find.byKey(keyButton2);
          final Finder findButton3 = find.byKey(keyButton3);
          final Finder findButton4 = find.byKey(keyButton4);

          await tester.tap(findButton1);
          await tester.tap(findButton2);
          await tester.tap(findButton3);

          expect(counter, 0);

          await tester.tap(findButton4);

          expect(counter, 1);
        },
      );
    },
  );

  group(
    'Play Button',
    () {
      testGoldens(
        'Play button should match golden image',
        (tester) async {
          final builder = DSButtonsTestUtils.createPlayButtonScenarios();

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.playButtonGoldenPath}/ds_play_button',
            autoHeight: true,
          );
        },
      );

      testWidgets(
        'Play button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSPlayButton button = DSButtonsTestUtils.buildPlayButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidgetBuilder(button);

          expect(wasTapped, false);

          await tester.tap(
            find.byWidget(button),
          );

          expect(wasTapped, true);
        },
      );
    },
  );

  group(
    'Pause Button',
    () {
      testGoldens(
        'Pause button should match golden image',
        (tester) async {
          final builder = DSButtonsTestUtils.createPauseButtonScenarios();

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            '${DSButtonsTestUtils.pauseButtonGoldenPath}/ds_pause_button',
            autoHeight: true,
          );
        },
      );

      testWidgets(
        'Pause button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSPauseButton button = DSButtonsTestUtils.buildPauseButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidgetBuilder(button);

          expect(wasTapped, false);

          final Finder findButton = find.byWidget(button);

          await tester.tap(findButton);

          expect(wasTapped, true);
        },
      );
    },
  );
}
