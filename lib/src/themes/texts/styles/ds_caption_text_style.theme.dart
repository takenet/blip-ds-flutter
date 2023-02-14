import 'package:flutter/material.dart';

import '../../colors/ds_colors.theme.dart';
import '../utils/ds_font_weights.theme.dart';
import 'ds_text_style.theme.dart';

/// A Design System's [TextStyle] primarily used by regular subtitles and descriptions.
class DSCaptionTextStyle extends DSTextStyle {
  const DSCaptionTextStyle({
    super.fontWeight = DSFontWeights.regular,
    super.color = DSColors.neutralDarkCity,
    super.decoration,
    super.overflow = TextOverflow.ellipsis,
  }) : super(
          fontSize: 14.0,
          height: 1.57,
        );
}
