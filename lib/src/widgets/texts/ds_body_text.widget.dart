import 'package:blip_ds/src/themes/texts/styles/ds_body_text_style.theme.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

/// A Design System's [Text] primarily used by body texts like messages and inputs.
///
/// Sets [DSBodyTextStyle] as [style] default value. This style's font variant is $fs-16-p1.
class DSBodyText extends DSText {
  /// Creates a Design System's [Text] with $fs-16-p1 font variant.
  DSBodyText({
    required super.text,
    super.key,
    super.fontWeight,
    super.color,
    super.overflow,
    super.decoration,
    super.textAlign,
  }) : super(
          style: DSBodyTextStyle(
            fontWeight: fontWeight,
            color: color,
            overflow: overflow,
            decoration: decoration,
          ),
        );
}
