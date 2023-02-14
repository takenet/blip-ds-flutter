import 'package:flutter/material.dart';

import '../../colors/ds_colors.theme.dart';
import '../utils/ds_font_weights.theme.dart';
import 'ds_text_style.theme.dart';

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
          fontSize: 16.0,
          height: 1.5,
        );
}
