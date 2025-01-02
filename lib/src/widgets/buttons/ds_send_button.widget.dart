import 'package:flutter/material.dart';

import '../../enums/ds_button_shape.enum.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_button.widget.dart';

class DSSendButton extends DSButton {
  DSSendButton({
    super.key,
    super.onPressed,
    super.isEnabled = true,
    super.isLoading,
    Color backgroundColor = DSColors.primaryNight,
    Color foregroundColor = DSColors.neutralLightSnow,
  }) : super(
          shape: DSButtonShape.rounded,
          leadingIcon: const Icon(
            color: DSColors.neutralLightSnow,
            DSIcons.send_solid,
          ),
          backgroundColor: isEnabled ? backgroundColor : DSColors.disabledBg,
          foregroundColor:
              isEnabled ? foregroundColor : DSColors.neutralMediumElephant,
        );
}
