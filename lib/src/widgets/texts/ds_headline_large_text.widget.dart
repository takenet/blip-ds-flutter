import '../../themes/texts/styles/ds_headline_large_text_style.theme.dart';
import 'ds_text.widget.dart';

/// A Design System's [Text] primarily used by large titles.
///
/// Sets [DSHeadlineLargeTextStyle] as [style] default value. This style's font variant is $fs-20-h2.
class DSHeadlineLargeText extends DSText {
  /// Creates a Design System's [Text] with $fs-20-h2 font variant.
  const DSHeadlineLargeText(
    super.text, {
    super.key,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
  }) : super(
          style: const DSHeadlineLargeTextStyle(),
        );

  const DSHeadlineLargeText.rich(
    super.textSpan, {
    super.key,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
  }) : super.rich(
          style: const DSHeadlineLargeTextStyle(),
        );
}
