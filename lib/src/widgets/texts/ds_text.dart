import 'package:blip_ds/src/themes/colors/ds_colors.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.dart';
import 'package:flutter/material.dart';

class DSText extends Text {
  const DSText({
    required String text,
    required super.style,
    super.key,
    FontWeight? fontWeight = DSFontWeights.regular,
    Color color = DSColors.neutralDarkCity,
    TextOverflow? overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
  }) : super(text);
}
