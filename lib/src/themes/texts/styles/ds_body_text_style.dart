import 'package:blip_ds/src/themes/colors/ds_colors.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.dart';
import 'package:flutter/material.dart';

/// Texts, messages and inputs.
class DSBodyTextStyle extends DSTextStyle {
  const DSBodyTextStyle({
    FontWeight fontWeight = DSFontWeights.regular,
    Color color = DSColors.neutralDarkCity,
  }) : super(
          fontSize: 16,
          fontWeight: fontWeight,
          color: color,
        );
}
