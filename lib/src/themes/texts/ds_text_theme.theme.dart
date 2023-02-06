import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_body_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_button_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_caption_small_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_caption_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_headline_large_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_headline_small_text_style.theme.dart';
import 'package:flutter/material.dart';

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
