import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

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
