import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

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
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
  }) : super(
          style: DSCaptionSmallTextStyle(
            fontWeight: fontWeight,
            color: color,
          ),
        );

  DSCaptionSmallText.rich(
    super.textSpan, {
    super.key,
    super.fontWeight,
    super.color,
    super.linkColor,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
  }) : super.rich(
          style: DSCaptionSmallTextStyle(
            fontWeight: fontWeight,
            color: color,
          ),
        );
}
