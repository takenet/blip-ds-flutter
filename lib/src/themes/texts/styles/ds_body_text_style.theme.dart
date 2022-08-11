import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';
import 'package:flutter/material.dart';

/// A Design System's [TextStyle] primarily used by body texts, like messages and inputs.
///
/// This style's font variant is $fs-16-p1.
class DSBodyTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-16-p1 font variant.
  const DSBodyTextStyle({
    super.fontWeight = DSFontWeights.regular,
    super.color = DSColors.neutralDarkCity,
    super.decoration,
    super.overflow = TextOverflow.ellipsis,
  }) : super(
          fontSize: 16,
        );
}
