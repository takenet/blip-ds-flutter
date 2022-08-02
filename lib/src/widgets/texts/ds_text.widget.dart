import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';
import 'package:flutter/material.dart';

/// A container that has some default properties which should be extended by others Design System's [Text].
class DSText extends Text {
  /// Creates a Design System's [Text].
  const DSText({
    required String text,
    required super.style,
    super.key,
    FontWeight? fontWeight = DSFontWeights.regular,
    Color color = DSColors.neutralDarkCity,
    TextOverflow? overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
  }) : super(text);
}
