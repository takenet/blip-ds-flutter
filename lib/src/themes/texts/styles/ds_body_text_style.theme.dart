import 'package:flutter/material.dart';

import 'ds_text_style.theme.dart';

/// A Design System's [TextStyle] primarily used by body texts, like messages and inputs.
///
/// This style's font variant is $fs-16-p1.
class DSBodyTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-16-p1 font variant.
  const DSBodyTextStyle({
    super.fontWeight,
    super.fontStyle,
    super.color,
    super.decoration,
    super.overflow,
    super.height = 1.5,
  }) : super(
          fontSize: 16.0,
        );
}
