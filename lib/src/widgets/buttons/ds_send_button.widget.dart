import 'package:blip_ds/src/enums/ds_button_shape.enum.dart';
import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';
import 'ds_button.widget.dart';

const size = Size(44.0, 44.0);

class DSSendButton extends DSButton {
  DSSendButton({
    super.key,
    super.onPressed,
    super.backgroundColor = DSColors.primaryNight,
    super.foregroundColor = DSColors.neutralLightSnow,
  }) : super(
          shape: DSButtonShape.rounded,
          leadingIcon: const ImageIcon(
            AssetImage(
              'assets/images/send_button.png',
              package: DSUtils.packageName,
            ),
          ),
        );
}
