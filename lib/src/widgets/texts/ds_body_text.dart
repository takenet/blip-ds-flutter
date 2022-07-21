import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSBodyText extends Text {
  DSBodyText({
    required String text,
    Key? key,
    FontWeight fontWeight = DSFontWeights.regular,
    Color color = DSColors.neutralDarkCity,
    TextOverflow? overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
  }) : super(
          text,
          key: key,
          style: DSBodyTextStyle(
            fontWeight: fontWeight,
            color: color,
            overflow: overflow,
            decoration: decoration,
          ),
        );
}
