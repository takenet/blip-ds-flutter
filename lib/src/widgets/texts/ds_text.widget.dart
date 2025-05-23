import 'package:flutter/material.dart';

import '../../services/ds_security.service.dart';
import '../../services/ds_theme.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../../utils/ds_linkify.util.dart';

/// A container that has some default properties which should be extended by others Design System's [Text].
class DSText extends StatelessWidget {
  final String? text;
  final InlineSpan? span;
  final TextStyle style;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color color;
  final Color linkColor;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool shouldLinkify;
  final bool isSelectable;
  final double? height;

  /// Creates a Design System's [Text].
  DSText(
    this.text, {
    required this.style,
    super.key,
    this.fontWeight = DSFontWeights.regular,
    this.fontStyle = FontStyle.normal,
    Color? color,
    Color? linkColor,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
    this.textAlign,
    this.maxLines,
    this.shouldLinkify = true,
    this.isSelectable = false,
    this.height,
  })  : color = DSThemeService.foregoundColor,
        linkColor = DSThemeService.isDarkMode
            ? DSColors.primaryLight
            : DSColors.primaryNight,
        span = null;

  DSText.rich(
    this.span, {
    required this.style,
    super.key,
    this.fontWeight = DSFontWeights.regular,
    this.fontStyle = FontStyle.normal,
    Color? color,
    Color? linkColor,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
    this.textAlign,
    this.maxLines,
    this.shouldLinkify = true,
    this.isSelectable = false,
    this.height,
  })  : color = DSThemeService.foregoundColor,
        linkColor = DSThemeService.isDarkMode
            ? DSColors.primaryLight
            : DSColors.primaryNight,
        text = null;

  @override
  Widget build(BuildContext context) =>
      DSSecurityService.isSelectableTextsEnabled && isSelectable
          ? _buildSelectableText()
          : _buildText();

  InlineSpan get _formattedText {
    List<InlineSpan>? formattedText;

    if (shouldLinkify) {
      if (text?.isNotEmpty ?? false) {
        formattedText = DSLinkify.plainText(
          text: text!,
          defaultStyle: style,
          linkColor: linkColor,
        );
      } else if (span is TextSpan) {
        formattedText = DSLinkify.textSpan(
          span: span!,
          defaultStyle: style,
          linkColor: linkColor,
        );
      }
    } else {
      formattedText = [span ?? TextSpan(text: text)];
    }

    return TextSpan(
      children: formattedText,
    );
  }

  Widget _buildSelectableText() => SelectionArea(
        child: _buildText(),
      );

  Widget _buildText() => Text.rich(
        _formattedText,
        key: key,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        textHeightBehavior: const TextHeightBehavior(
          leadingDistribution: TextLeadingDistribution.even,
        ),
      );
}
