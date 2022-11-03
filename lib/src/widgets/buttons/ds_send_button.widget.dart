import 'package:blip_ds/src/enums/ds_button_shape.enum.dart';
import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_button.widget.dart';

class DSSendButton extends DSButton {
  DSSendButton({
    super.key,
    super.onPressed,
    super.backgroundColor = DSColors.primaryNight,
    super.foregroundColor = DSColors.neutralLightSnow,
  }) : super(
          shape: DSButtonShape.rounded,
          leadingIcon: const Icon(
            DSIcons.send_solid,
          ),
        );
}
