import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSCaptionSmallText extends Text {
  DSCaptionSmallText({
    required String text,
    Key? key,
    FontWeight fontWeight = DSFontWeights.regular,
    Color color = DSColors.neutralDarkCity,
  }) : super(
          text,
          key: key,
          style: DSCaptionSmallTextStyle(
            fontWeight: fontWeight,
            color: color,
          ),
        );
}
