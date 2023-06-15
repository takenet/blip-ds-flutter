import 'package:flutter/material.dart';

import 'ds_text_style.theme.dart';

/// A Design System's [TextStyle] primarily used by regular subtitles and descriptions.
class DSCaptionTextStyle extends DSTextStyle {
  const DSCaptionTextStyle({
    super.fontWeight,
    super.fontStyle,
    super.color,
    super.decoration,
    super.overflow,
    super.height = 1.57,
  }) : super(
          fontSize: 14.0,
        );
}
