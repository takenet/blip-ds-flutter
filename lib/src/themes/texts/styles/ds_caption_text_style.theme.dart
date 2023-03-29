import 'package:flutter/material.dart';

import 'ds_text_style.theme.dart';

/// A Design System's [TextStyle] primarily used by regular subtitles and descriptions.
class DSCaptionTextStyle extends DSTextStyle {
  const DSCaptionTextStyle({
    super.fontWeight,
    super.color,
    super.decoration,
    super.overflow,
  }) : super(
          fontSize: 14.0,
          height: 1.57,
        );
}
