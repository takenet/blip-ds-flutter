import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_icon_button.widget.dart';

class DSAttachmentButton extends DSIconButton {
  DSAttachmentButton({
    super.key,
    required super.onPressed,
    super.isLoading,
  }) : super(
          icon: const Icon(
            DSIcons.attach_outline,
            color: DSColors.neutralDarkRooftop,
          ),
        );
}
