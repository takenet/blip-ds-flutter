import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSButtonText extends Text {
  DSButtonText({
    required String text,
    Key? key,
    Color color = DSColors.neutralLightSnow,
  }) : super(
          text,
          key: key,
          style: DSButtonTextStyle(
            color: color,
          ),
        );
}
