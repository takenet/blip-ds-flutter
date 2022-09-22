import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_pause_button.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_play_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Standard Button',
    () {
      testWidgets(
        'Standard button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSButton button = _buildStandardButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

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
              _buildStandardButton(
                key: keyButton1,
                onPressed: null,
                isEnabled: false,
              ),
              _buildStandardButton(
                key: keyButton2,
                onPressed: null,
                isEnabled: true,
              ),
              _buildStandardButton(
                key: keyButton3,
                onPressed: incrementCounter,
                isEnabled: false,
              ),
              _buildStandardButton(
                key: keyButton4,
                onPressed: incrementCounter,
                isEnabled: true,
              ),
            ],
          );

          await tester.pumpWidget(
            _buildMaterialApp(buttons),
          );

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

      testWidgets(
        'Standard button should have leading icon',
        (tester) async {
          const IconData icon = Icons.add;

          final DSButton button = _buildStandardButton(
            onPressed: () {},
            leadingIcon: const Icon(icon),
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findIcon = find.byIcon(icon);

          expect(findIcon, findsOneWidget);
        },
      );

      testWidgets(
        'Standard button should have label',
        (tester) async {
          const String label = 'Test Label 123 !@#';

          final DSButton button = _buildStandardButton(
            onPressed: () {},
            label: label,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findLabel = find.text(
            label,
            findRichText: true,
          );

          expect(findLabel, findsOneWidget);
        },
      );

      testWidgets(
        'Standard button should have trailing icon',
        (tester) async {
          const IconData icon = Icons.add;

          final DSButton button = _buildStandardButton(
            onPressed: () {},
            trailingIcon: const Icon(icon),
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findIcon = find.byIcon(icon);

          expect(findIcon, findsOneWidget);
        },
      );

      testWidgets(
        'Standard button should have loading behavior',
        (tester) async {
          const IconData icon = Icons.add;

          final DSButton button = _buildStandardButton(
            onPressed: () {},
            isLoading: true,
            trailingIcon: const Icon(icon),
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findLoading = find.byType(DSRingLoading);
          final Finder findIcon = find.byIcon(icon);

          expect(findLoading, findsOneWidget);
          expect(findIcon, findsNothing);
        },
      );

      testWidgets(
        'Standard button should have leading icon, label and trailing icon',
        (tester) async {
          const IconData leadingIcon = Icons.add;
          const String label = 'Test Label 123 !@#';
          const IconData trailingIcon = Icons.remove;

          final DSButton button = _buildStandardButton(
            onPressed: () {},
            leadingIcon: const Icon(leadingIcon),
            label: label,
            trailingIcon: const Icon(trailingIcon),
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findLeadingIcon = find.byIcon(leadingIcon);
          final Finder findTrailingIcon = find.byIcon(trailingIcon);

          final Finder findLabel = find.text(
            label,
            findRichText: true,
          );

          expect(findLeadingIcon, findsOneWidget);
          expect(findLabel, findsOneWidget);
          expect(findTrailingIcon, findsOneWidget);
        },
      );
    },
  );

  group(
    'Primary Button',
    () {
      testWidgets(
        'Primary button should be a standard button subclass',
        (tester) async {
          final DSPrimaryButton button = _buildPrimaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.bySubtype<DSButton>();

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Primary button should have Primary Night background color when enabled',
        (tester) async {
          final DSPrimaryButton button = _buildPrimaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSPrimaryButton &&
                widget.backgroundColor == DSColors.primaryNight,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Primary button should have Disabled BG background color when disabled',
        (tester) async {
          final DSPrimaryButton button = _buildPrimaryButton(
            isEnabled: false,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSPrimaryButton &&
                widget.backgroundColor == DSColors.disabledBg,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Primary button should have Neutral Light Snow foreground color when enabled',
        (tester) async {
          final DSPrimaryButton button = _buildPrimaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSPrimaryButton &&
                widget.foregroundColor == DSColors.neutralLightSnow,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Primary button should have Neutral Medium Elephant foreground color when disabled',
        (tester) async {
          final DSPrimaryButton button = _buildPrimaryButton(
            isEnabled: false,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSPrimaryButton &&
                widget.foregroundColor == DSColors.neutralMediumElephant,
          );

          expect(findButton, findsOneWidget);
        },
      );
    },
  );

  group(
    'Secondary Button',
    () {
      testWidgets(
        'Secondary button should be a standard button subclass',
        (tester) async {
          final DSSecondaryButton button = _buildSecondaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.bySubtype<DSButton>();

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Secondary button should have Neutral Light Snow background color',
        (tester) async {
          final DSSecondaryButton button = _buildSecondaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSSecondaryButton &&
                widget.backgroundColor == DSColors.neutralLightSnow,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Secondary button should have Primary Night foreground color when enabled',
        (tester) async {
          final DSSecondaryButton button = _buildSecondaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSSecondaryButton &&
                widget.foregroundColor == DSColors.primaryNight,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Secondary button should have Neutral Medium Elephant foreground color when disabled',
        (tester) async {
          final DSSecondaryButton button = _buildSecondaryButton(
            isEnabled: false,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSSecondaryButton &&
                widget.foregroundColor == DSColors.neutralMediumElephant,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Secondary button should have Primary Night border color when enabled',
        (tester) async {
          final DSSecondaryButton button = _buildSecondaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSSecondaryButton &&
                widget.borderColor == DSColors.primaryNight,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Secondary button should have Neutral Medium Elephant border color when disabled',
        (tester) async {
          final DSSecondaryButton button = _buildSecondaryButton(
            isEnabled: false,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSSecondaryButton &&
                widget.borderColor == DSColors.neutralMediumElephant,
          );

          expect(findButton, findsOneWidget);
        },
      );
    },
  );

  group(
    'Tertiary Button',
    () {
      testWidgets(
        'Tertiary button should be a standard button subclass',
        (tester) async {
          final DSTertiaryButton button = _buildTertiaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.bySubtype<DSButton>();

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Tertiary button should not have background color',
        (tester) async {
          final DSTertiaryButton button = _buildTertiaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSTertiaryButton &&
                widget.backgroundColor == Colors.transparent,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Tertiary button should have Neutral Dark City foreground color when enabled',
        (tester) async {
          final DSTertiaryButton button = _buildTertiaryButton();

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSTertiaryButton &&
                widget.foregroundColor == DSColors.neutralDarkCity,
          );

          expect(findButton, findsOneWidget);
        },
      );

      testWidgets(
        'Tertiary button should have Neutral Medium Elephant foreground color when disabled',
        (tester) async {
          final DSTertiaryButton button = _buildTertiaryButton(
            isEnabled: false,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findButton = find.byWidgetPredicate(
            (widget) =>
                widget is DSTertiaryButton &&
                widget.foregroundColor == DSColors.neutralMediumElephant,
          );

          expect(findButton, findsOneWidget);
        },
      );
    },
  );

  group(
    'Play Button',
    skip: true, // TODO: golden test
    () {
      // TODO: package name error
      testWidgets(
        'Play button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSPlayButton button = _buildPlayButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          expect(wasTapped, false);

          await tester.tap(
            find.byWidget(button),
          );

          expect(wasTapped, true);
        },
      );

      // TODO: package name error
      testWidgets(
        'Play button should have Neutral Light Snow color',
        (tester) async {
          final button = _buildPlayButton(
            onPressed: () {},
            iconColor: DSPlayButtonIconColor.neutralLightSnow,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findImage = find.image(
            const AssetImage(
              'assets/images/play_neutral_light_snow.png',
            ),
          );

          expect(findImage, findsOneWidget);
        },
      );

      // TODO: package name error
      testWidgets(
        'Play button should have Neutral Dark Rooftop color',
        (tester) async {
          final button = _buildPlayButton(
            onPressed: () {},
            iconColor: DSPlayButtonIconColor.neutralDarkRooftop,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          final Finder findImage = find.image(
            const AssetImage(
              'assets/images/play_neutral_dark_rooftop.png',
            ),
          );

          expect(findImage, findsOneWidget);
        },
      );
    },
  );

  group(
    'Pause Button',
    () {
      testWidgets(
        'Pause button should be tapped and return true',
        (tester) async {
          bool wasTapped = false;

          final DSPauseButton button = _buildPauseButton(
            onPressed: () => wasTapped = true,
          );

          await tester.pumpWidget(
            _buildMaterialApp(button),
          );

          expect(wasTapped, false);

          final Finder findButton = find.byWidget(button);

          await tester.tap(findButton);

          expect(wasTapped, true);
        },
      );

      testWidgets(
        'Pause button should have color customization',
        (tester) async {
          const greenColor = DSColors.primaryGreensTrue;
          const redColor = DSColors.extendRedsLipstick;

          final DSPauseButton greenButton = _buildPauseButton(
            color: greenColor,
            onPressed: () {},
          );

          final DSPauseButton redButton = _buildPauseButton(
            color: redColor,
            onPressed: () {},
          );

          final buttons = Column(
            children: [
              greenButton,
              redButton,
            ],
          );

          await tester.pumpWidget(
            _buildMaterialApp(buttons),
          );

          final Finder findGreenButton = find.byWidgetPredicate(
            (widget) => widget is DSPauseButton && widget.color == greenColor,
          );

          final Finder findRedButton = find.byWidgetPredicate(
            (widget) => widget is DSPauseButton && widget.color == redColor,
          );

          expect(findGreenButton, findsOneWidget);
          expect(findRedButton, findsOneWidget);
        },
      );
    },
  );
}

MaterialApp _buildMaterialApp(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: child,
    ),
  );
}

DSButton _buildStandardButton({
  required void Function()? onPressed,
  Key? key,
  bool isEnabled = true,
  Icon? leadingIcon,
  String? label,
  Icon? trailingIcon,
  bool isLoading = false,
}) {
  return DSButton(
    key: key,
    onPressed: onPressed,
    backgroundColor: DSColors.primaryNight,
    foregroundColor: DSColors.neutralLightSnow,
    isEnabled: isEnabled,
    leadingIcon: leadingIcon,
    label: label,
    trailingIcon: trailingIcon,
    isLoading: isLoading,
  );
}

DSPrimaryButton _buildPrimaryButton({
  bool isEnabled = true,
}) {
  return DSPrimaryButton(
    onPressed: () {},
    isEnabled: isEnabled,
  );
}

DSSecondaryButton _buildSecondaryButton({
  bool isEnabled = true,
}) {
  return DSSecondaryButton(
    onPressed: () {},
    isEnabled: isEnabled,
  );
}

DSTertiaryButton _buildTertiaryButton({
  bool isEnabled = true,
}) {
  return DSTertiaryButton(
    onPressed: () {},
    isEnabled: isEnabled,
  );
}

DSPlayButton _buildPlayButton({
  required void Function() onPressed,
  DSPlayButtonIconColor iconColor = DSPlayButtonIconColor.neutralDarkRooftop,
}) {
  return DSPlayButton(
    icon: iconColor,
    onPressed: onPressed,
  );
}

DSPauseButton _buildPauseButton({
  required void Function() onPressed,
  Color color = DSColors.primaryNight, // TODO: change it to be DSColors only
}) {
  return DSPauseButton(
    onPressed: onPressed,
    color: color,
  );
}
