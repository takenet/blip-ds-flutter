import '../../themes/texts/styles/ds_caption_text_style.theme.dart';
import 'ds_text.widget.dart';

/// A Design System's [Text] primarily used by regular subtitles and descriptions.
///
/// Sets [DSCaptionTextStyle] as [style] default value.
class DSCaptionText extends DSText {
  /// Creates a Design System's [Text] with $fs-14-p2 font variant.
  DSCaptionText(
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
    super.height,
  }) : super(
          style: DSCaptionTextStyle(
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            decoration: decoration,
            overflow: overflow,
            height: height,
          ),
        );

  DSCaptionText.rich(
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
    super.height,
  }) : super.rich(
          style: DSCaptionTextStyle(
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            decoration: decoration,
            overflow: overflow,
            height: height,
          ),
        );
}
