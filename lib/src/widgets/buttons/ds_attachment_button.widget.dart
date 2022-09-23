import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSAttachmentButton extends DSIconButton {
  DSAttachmentButton({
    super.key,
    required super.onPressed,
    super.isLoading,
  }) : super(
          icon: const ImageIcon(
            size: 20,
            color: DSColors.neutralDarkRooftop,
            AssetImage(
              'assets/images/clip.png',
              package: DSUtils.packageName,
            ),
          ),
        );
}