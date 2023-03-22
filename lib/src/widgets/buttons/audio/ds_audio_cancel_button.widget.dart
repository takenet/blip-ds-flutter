import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

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
