import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSAttachmentButton extends DSIconButton {
  DSAttachmentButton({
    super.key,
    required super.onPressed,
  }) : super(
          icon: Image.asset(
            'assets/images/clip.png',
            package: DSUtils.packageName,
            height: 20,
          ),
        );
}
