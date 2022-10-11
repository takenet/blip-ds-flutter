import 'package:blip_ds/src/themes/texts/styles/ds_button_text_style.theme.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

/// A Design System's [Text] primarily used by buttons.
///
/// Sets [DSButtonTextStyle] as [style] default value. This style's font variant is $fs-16-p1.
class DSButtonText extends DSText {
  /// Creates a Design System's [Text] with $fs-16-p1 font variant.
  DSButtonText(
    super.text, {
    required super.color,
    super.key,
    super.textAlign,
    super.maxLines,
  }) : super(
          style: DSButtonTextStyle(
            color: color,
          ),
          shouldLinkify: false,
        );

  DSButtonText.rich(
    super.textSpan, {
    required super.color,
    super.key,
    super.textAlign,
    super.maxLines,
  }) : super.rich(
          style: DSButtonTextStyle(
            color: color,
          ),
          shouldLinkify: false,
        );
}
