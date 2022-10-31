import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/buttons/ds_pause_button.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_play_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

typedef ButtonBuilderFunction = DSButton Function({
  required void Function()? onPressed,
  bool isEnabled,
  Icon? leadingIcon,
  String? label,
  Icon? trailingIcon,
  bool isLoading,
});

class DSButtonsTestUtils {
  static const String enabledStandardButtonGoldenPath = 'ds_button/enabled';
  static const String disabledStandardButtonGoldenPath = 'ds_button/disabled';

  static const String enabledPrimaryButtonGoldenPath =
      'ds_primary_button/enabled';
  static const String disabledPrimaryButtonGoldenPath =
      'ds_primary_button/disabled';

  static const String enabledSecondaryButtonGoldenPath =
      'ds_secondary_button/enabled';
  static const String disabledSecondaryButtonGoldenPath =
      'ds_secondary_button/disabled';

  static const String enabledTertiaryButtonGoldenPath =
      'ds_tertiary_button/enabled';
  static const String disabledTertiaryButtonGoldenPath =
      'ds_tertiary_button/disabled';

  static const String playButtonGoldenPath = 'ds_play_button';
  static const String pauseButtonGoldenPath = 'ds_pause_button';

  static GoldenBuilder createButtonScenarios(
    final String buttonName,
    final String description, {
    required final ButtonBuilderFunction buttonBuilder,
    required final bool isEnabled,
    required final bool isLoading,
  }) {
    const leadingIcon = Icon(Icons.search);
    const trailingIcon = Icon(Icons.access_alarm);
    const label = 'Click Here';

    final builder = GoldenBuilder.grid(
      columns: 3,
      widthToHeightRatio: 1,
    );

    if (isLoading) {
      builder.addScenario(
        '$buttonName - ($description) Loading',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
          isLoading: isLoading,
          trailingIcon: trailingIcon,
          leadingIcon: leadingIcon,
          label: label,
        ),
      );
    } else {
      builder.addScenario(
        '$buttonName - ($description) Blank',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
        ),
      );

      builder.addScenario(
        '$buttonName - ($description) Leading Icon Only',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
          leadingIcon: leadingIcon,
        ),
      );

      builder.addScenario(
        '$buttonName - ($description) Trailing Icon Only',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
          trailingIcon: trailingIcon,
        ),
      );

      builder.addScenario(
        '$buttonName - ($description) Label Only',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
          label: label,
        ),
      );

      builder.addScenario(
        '$buttonName - ($description) Label + Trailing Icon',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
          trailingIcon: trailingIcon,
          label: label,
        ),
      );

      builder.addScenario(
        '$buttonName - ($description) Leading Icon + Label',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
          leadingIcon: leadingIcon,
          label: label,
        ),
      );

      builder.addScenario(
        '$buttonName - ($description) Leading Icon + Trailing Icon',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
          trailingIcon: trailingIcon,
          leadingIcon: leadingIcon,
        ),
      );

      builder.addScenario(
        '$buttonName - ($description) Leading Icon + Label + Trailing Icon',
        buttonBuilder.call(
          onPressed: () {},
          isEnabled: isEnabled,
          trailingIcon: trailingIcon,
          leadingIcon: leadingIcon,
          label: label,
        ),
      );
    }

    return builder;
  }

  static GoldenBuilder createPlayButtonScenarios() {
    final builder = GoldenBuilder.column();

    builder.addScenario(
      'Neutral Light Snow Color',
      buildPlayButton(
        onPressed: () {},
        iconColor: DSPlayButtonIconColor.neutralLightSnow,
      ),
    );

    builder.addScenario(
      'Neutral Dark Rooftop Color',
      buildPlayButton(
        onPressed: () {},
        iconColor: DSPlayButtonIconColor.neutralDarkRooftop,
      ),
    );

    return builder;
  }

  static GoldenBuilder createPauseButtonScenarios() {
    final builder = GoldenBuilder.column();

    builder.addScenario(
      'Primary Greens True Color',
      buildPauseButton(
        onPressed: () {},
        color: DSColors.primaryGreensTrue,
      ),
    );

    builder.addScenario(
      'Extend Reds Lipstick Color',
      buildPauseButton(
        onPressed: () {},
        color: DSColors.extendRedsLipstick,
      ),
    );

    return builder;
  }

  static DSButton buildStandardButton({
    required final void Function()? onPressed,
    final Key? key,
    final bool isEnabled = true,
    final Icon? leadingIcon,
    final String? label,
    final Icon? trailingIcon,
    final bool isLoading = false,
  }) {
    return DSButton(
      key: key,
      onPressed: onPressed,
      backgroundColor: isEnabled ? DSColors.primaryNight : DSColors.disabledBg,
      foregroundColor: isEnabled
          ? DSColors.neutralLightSnow
          : DSColors.neutralMediumElephant,
      isEnabled: isEnabled,
      leadingIcon: leadingIcon,
      label: label,
      trailingIcon: trailingIcon,
      isLoading: isLoading,
    );
  }

  static DSPrimaryButton buildPrimaryButton({
    required final void Function()? onPressed,
    final Key? key,
    final Icon? leadingIcon,
    final String? label,
    final Icon? trailingIcon,
    final bool isEnabled = true,
    final bool isLoading = false,
  }) {
    return DSPrimaryButton(
      key: key,
      onPressed: onPressed,
      isEnabled: isEnabled,
      isLoading: isLoading,
      leadingIcon: leadingIcon,
      label: label,
      trailingIcon: trailingIcon,
    );
  }

  static DSSecondaryButton buildSecondaryButton({
    required final void Function()? onPressed,
    final Key? key,
    final Icon? leadingIcon,
    final String? label,
    final Icon? trailingIcon,
    final bool isEnabled = true,
    final bool isLoading = false,
  }) {
    return DSSecondaryButton(
      key: key,
      onPressed: onPressed,
      isEnabled: isEnabled,
      isLoading: isLoading,
      leadingIcon: leadingIcon,
      label: label,
      trailingIcon: trailingIcon,
    );
  }

  static DSTertiaryButton buildTertiaryButton({
    required final void Function()? onPressed,
    final Key? key,
    final Icon? leadingIcon,
    final String? label,
    final Icon? trailingIcon,
    final bool isEnabled = true,
    final bool isLoading = false,
  }) {
    return DSTertiaryButton(
      key: key,
      onPressed: onPressed,
      isEnabled: isEnabled,
      isLoading: isLoading,
      leadingIcon: leadingIcon,
      label: label,
      trailingIcon: trailingIcon,
    );
  }

  static DSPlayButton buildPlayButton({
    required final void Function() onPressed,
    final DSPlayButtonIconColor iconColor =
        DSPlayButtonIconColor.neutralDarkRooftop,
  }) {
    return DSPlayButton(
      icon: iconColor,
      onPressed: onPressed,
    );
  }

  static DSPauseButton buildPauseButton({
    required final void Function() onPressed,
    final Color color = DSColors.primaryNight,
  }) {
    return DSPauseButton(
      onPressed: onPressed,
      color: color,
    );
  }
}
