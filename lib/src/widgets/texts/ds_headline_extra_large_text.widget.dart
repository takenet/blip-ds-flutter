import '../../themes/texts/styles/ds_headline_extra_large_text_style.theme.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import 'ds_text.widget.dart';

/// A Design System's [Text] primarily used by large titles.
///
/// Sets [DSHeadlineExtraLargeTextStyle] as [style] default value. This style's font variant is $fs-32-h2.
class DSHeadlineExtraLargeText extends DSText {
  /// Creates a Design System's [Text] with $fs-32-h2 font variant.
  DSHeadlineExtraLargeText(
    super.text, {
    super.key,
    super.color,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.fontWeight = DSFontWeights.semiBold,
    super.fontStyle,
    super.shouldLinkify,
    super.isSelectable,
    super.height = 1.4,
  }) : super(
          style: DSHeadlineExtraLargeTextStyle(
            color: color,
            overflow: overflow,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            height: height,
          ),
        );

  DSHeadlineExtraLargeText.rich(
    super.textSpan, {
    super.key,
    super.color,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.fontWeight = DSFontWeights.semiBold,
    super.fontStyle,
    super.shouldLinkify,
    super.isSelectable,
    super.height = 1.4,
  }) : super.rich(
          style: DSHeadlineExtraLargeTextStyle(
            color: color,
            overflow: overflow,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            height: height,
          ),
        );
}
