import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import 'ds_text.widget.dart';

/// A Design System's [Text] primarily used by body texts like messages and inputs.
///
/// Sets [DSBodyTextStyle] as [style] default value. This style's font variant is $fs-16-p1.
class DSBodyText extends DSText {
  /// Creates a Design System's [Text] with $fs-16-p1 font variant.
  DSBodyText(
    super.text, {
    super.key,
    super.fontWeight,
    super.fontStyle,
    super.color,
    super.linkColor,
    super.overflow,
    super.decoration,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
    super.isSelectable,
  }) : super(
          style: DSBodyTextStyle(
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            decoration: decoration,
            overflow: overflow,
          ),
        );

  DSBodyText.rich(
    super.textSpan, {
    super.key,
    super.fontWeight,
    super.fontStyle,
    super.color,
    super.linkColor,
    super.overflow,
    super.decoration,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
    super.isSelectable,
  }) : super.rich(
          style: DSBodyTextStyle(
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            decoration: decoration,
            overflow: overflow,
          ),
        );
}
