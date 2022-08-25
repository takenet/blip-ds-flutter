import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';
import 'package:blip_ds/src/utils/ds_linkify.util.dart';
import 'package:flutter/material.dart';

/// A container that has some default properties which should be extended by others Design System's [Text].
class DSText extends StatelessWidget {
  final String? text;
  final InlineSpan? textSpan;
  final TextStyle style;
  final FontWeight? fontWeight;
  final Color color;
  final Color linkColor;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool shouldLinkify;

  /// Creates a Design System's [Text].
  const DSText({
    required this.text,
    required this.style,
    super.key,
    this.fontWeight = DSFontWeights.regular,
    this.color = DSColors.neutralDarkCity,
    this.linkColor = DSColors.primaryNight,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
    this.textAlign,
    this.maxLines,
    this.shouldLinkify = true,
  }) : textSpan = null;

  const DSText.rich({
    required this.textSpan,
    required this.style,
    super.key,
    this.fontWeight = DSFontWeights.regular,
    this.color = DSColors.neutralDarkCity,
    this.linkColor = DSColors.primaryNight,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
    this.textAlign,
    this.maxLines,
    this.shouldLinkify = true,
  }) : text = null;

  @override
  Widget build(BuildContext context) {
    List<InlineSpan>? formattedText;

    if (shouldLinkify) {
      if (text?.isNotEmpty ?? false) {
        formattedText = DSLinkify.linkifyPlainText(
          text: text!,
          defaultStyle: style,
          linkColor: linkColor,
        );
      } else if (textSpan != null) {
        formattedText = DSLinkify.linkifyTextSpan(
          textSpan: textSpan!,
          defaultStyle: style,
          linkColor: linkColor,
        );
      }
    } else {
      formattedText = [textSpan ?? TextSpan(text: text)];
    }

    return Text.rich(
      TextSpan(
        children: formattedText,
      ),
      key: key,
      style: style,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
