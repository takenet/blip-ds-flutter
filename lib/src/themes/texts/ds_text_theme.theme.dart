import 'package:flutter/material.dart';

import '../colors/ds_colors.theme.dart';
import 'styles/ds_body_text_style.theme.dart';
import 'styles/ds_button_text_style.theme.dart';
import 'styles/ds_caption_small_text_style.theme.dart';
import 'styles/ds_caption_text_style.theme.dart';
import 'styles/ds_headline_large_text_style.theme.dart';
import 'styles/ds_headline_small_text_style.theme.dart';

/// A [TextTheme] used by Material Design to automatically apply our Design System's [TextStyle].
class DSTextTheme extends TextTheme {
  /// Creates a Design System's [TextTheme].
  const DSTextTheme()
      : super(
          displayLarge: const DSHeadlineLargeTextStyle(),
          displayMedium: const DSHeadlineSmallTextStyle(),
          bodyLarge: const DSBodyTextStyle(),
          labelLarge: const DSButtonTextStyle(
            color: DSColors.neutralDarkCity,
          ),
          titleMedium: const DSCaptionTextStyle(),
          titleSmall: const DSCaptionSmallTextStyle(),
        );
}
