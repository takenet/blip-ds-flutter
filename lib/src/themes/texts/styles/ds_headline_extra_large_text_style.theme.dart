import 'package:flutter/material.dart';

import '../utils/ds_font_weights.theme.dart';
import 'ds_text_style.theme.dart';

/// A Design System's [TextStyle] primarily used by large titles.
///
/// This style's font variant is $fs-32-h2.
class DSHeadlineExtraLargeTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-32-h2 font variant.
  const DSHeadlineExtraLargeTextStyle({
    super.color,
    super.overflow,
    super.fontWeight = DSFontWeights.semiBold,
    super.fontStyle,
    super.height = 1.25,
  }) : super(
          fontSize: 32.0,
        );
}
