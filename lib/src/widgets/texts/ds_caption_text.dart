import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSCaptionText extends Text {
  DSCaptionText({
    required String text,
    Key? key,
    FontWeight fontWeight = DSFontWeights.regular,
    Color color = DSColors.neutralDarkCity,
  }) : super(
          text,
          key: key,
          style: DSCaptionTextStyle(
            fontWeight: fontWeight,
            color: color,
          ),
        );
}
