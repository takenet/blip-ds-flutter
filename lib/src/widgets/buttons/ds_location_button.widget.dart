import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSLocationButton extends DSButton {
  DSLocationButton({
    super.key,
    super.onPressed,
    super.isEnabled = true,
    super.label,
    super.autoSize,
    Color backgroundColor = DSColors.primaryLight,
    Color foregroundColor = DSColors.neutralDarkCity,
  }) : super(
          borderRadius: 20.0,
          leadingIcon: const Icon(
            DSIcons.localization_outline,
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        );
}
