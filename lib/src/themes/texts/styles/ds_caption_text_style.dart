import 'package:flutter/material.dart';
import 'package:blip_ds/src/themes/colors/ds_colors.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.dart';

/// Regular subtitles and descriptions.
class DSCaptionTextStyle extends DSTextStyle {
  const DSCaptionTextStyle({
    FontWeight fontWeight = DSFontWeights.regular,
    Color color = DSColors.neutralDarkCity,
  }) : super(
          fontSize: 14,
          fontWeight: fontWeight,
          color: color,
        );
}
