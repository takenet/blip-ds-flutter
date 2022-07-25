import 'package:blip_ds/src/themes/colors/ds_colors.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.dart';
import 'package:flutter/material.dart';

/// A Design System's [TextStyle] primarily used by body texts, like messages and inputs.
class DSBodyTextStyle extends DSTextStyle {
  const DSBodyTextStyle({
    super.fontWeight = DSFontWeights.regular,
    super.color = DSColors.neutralDarkCity,
    super.decoration,
    super.overflow = TextOverflow.ellipsis,
  }) : super(
          fontSize: 16,
        );
}
