import 'package:flutter/material.dart';

import '../utils/ds_font_weights.theme.dart';
import 'ds_text_style.theme.dart';

/// A Design System's [TextStyle] primarily used by large titles.
///
/// This style's font variant is $fs-20-h4.
class DSHeadlineLargeTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-20-h4 font variant.
  const DSHeadlineLargeTextStyle({
    super.color,
    super.overflow,
    super.fontWeight = DSFontWeights.bold,
  }) : super(
          fontSize: 20.0,
          height: 1.4,
        );
}
