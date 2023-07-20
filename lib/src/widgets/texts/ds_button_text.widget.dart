import '../../themes/texts/styles/ds_button_text_style.theme.dart';
import 'ds_text.widget.dart';

/// A Design System's [Text] primarily used by buttons.
///
/// Sets [DSButtonTextStyle] as [style] default value. This style's font variant is $fs-16-p1.
class DSButtonText extends DSText {
  /// Creates a Design System's [Text] with $fs-16-p1 font variant.
  DSButtonText(
    super.text, {
    required super.color,
    super.key,
    super.overflow,
    super.fontStyle,
    super.textAlign,
    super.maxLines,
    super.isSelectable,
    super.height = 1.5,
  }) : super(
          style: DSButtonTextStyle(
            color: color,
            overflow: overflow,
            fontStyle: fontStyle,
            height: height,
          ),
          shouldLinkify: false,
        );

  DSButtonText.rich(
    super.textSpan, {
    required super.color,
    super.key,
    super.overflow,
    super.fontStyle,
    super.textAlign,
    super.maxLines,
    super.isSelectable,
    super.height = 1.5,
  }) : super.rich(
          style: DSButtonTextStyle(
            color: color,
            overflow: overflow,
            fontStyle: fontStyle,
            height: height,
          ),
          shouldLinkify: false,
        );
}
