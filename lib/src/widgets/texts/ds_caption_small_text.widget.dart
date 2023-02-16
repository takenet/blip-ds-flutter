import '../../themes/texts/styles/ds_caption_small_text_style.theme.dart';
import 'ds_text.widget.dart';

/// A Design System's [Text] primarily used by small subtitles and descriptions.
///
/// Sets [DSCaptionSmallTextStyle] as [style] default value. This style's font variant is $fs-12-p3.
class DSCaptionSmallText extends DSText {
  /// Creates a Design System's [Text] with $fs-12-p3 font variant.
  DSCaptionSmallText(
    super.text, {
    super.key,
    super.fontWeight,
    super.color,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
    super.isSelectable,
  }) : super(
          style: DSCaptionSmallTextStyle(
            fontWeight: fontWeight,
            color: color,
            overflow: overflow,
          ),
        );

  DSCaptionSmallText.rich(
    super.textSpan, {
    super.key,
    super.fontWeight,
    super.color,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
    super.isSelectable,
  }) : super.rich(
          style: DSCaptionSmallTextStyle(
            fontWeight: fontWeight,
            color: color,
            overflow: overflow,
          ),
        );
}
