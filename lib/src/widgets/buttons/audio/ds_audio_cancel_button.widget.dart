import 'package:flutter/material.dart';

import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../ds_tertiary_button.widget.dart';

class DSAudioCancelButton extends DSTertiaryButton {
  DSAudioCancelButton({
    super.key,
    super.onPressed,
    super.label,
    super.isEnabled,
  }) : super(
          leadingIcon: const Icon(
            DSIcons.trash_outline,
            color: DSColors.extendRedsLipstick,
            size: 24.0,
          ),
        );
}
