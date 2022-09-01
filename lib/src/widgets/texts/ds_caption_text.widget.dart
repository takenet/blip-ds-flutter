import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

/// A Design System's [Text] primarily used by regular subtitles and descriptions.
///
/// Sets [DSCaptionTextStyle] as [style] default value.
class DSCaptionText extends DSText {
  /// Creates a Design System's [Text] with $fs-14-p2 font variant.
  DSCaptionText({
    required super.text,
    super.key,
    super.fontWeight,
    super.color,
    super.linkColor,
    super.decoration,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
  }) : super(
          style: DSCaptionTextStyle(
            fontWeight: fontWeight,
            color: color,
            decoration: decoration,
          ),
        );

  DSCaptionText.rich({
    required super.textSpan,
    super.key,
    super.fontWeight,
    super.color,
    super.linkColor,
    super.decoration,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
  }) : super.rich(
          style: DSCaptionTextStyle(
            fontWeight: fontWeight,
            color: color,
            decoration: decoration,
          ),
        );
}
