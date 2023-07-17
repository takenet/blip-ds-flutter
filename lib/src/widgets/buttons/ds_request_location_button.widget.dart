import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSRequestLocationButton extends DSButton {
  DSRequestLocationButton({
    super.key,
    super.label,
  }) : super(
          onPressed: null,
          borderRadius: 20.0,
          leadingIcon: const Icon(
            DSIcons.localization_outline,
            color: DSColors.neutralDarkCity,
          ),
          backgroundColor: DSColors.primaryLight,
          foregroundColor: DSColors.neutralDarkCity,
        );
}
