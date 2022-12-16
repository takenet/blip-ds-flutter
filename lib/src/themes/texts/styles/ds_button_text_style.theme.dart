import 'package:blip_ds/src/themes/texts/styles/ds_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';

/// A Design System's [TextStyle] primarily used by buttons.
///
/// This style's font variant is $fs-16-p1.
class DSButtonTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-16-p1 font variant.
  const DSButtonTextStyle({
    required super.color,
  }) : super(
          fontSize: 16.0,
          fontWeight: DSFontWeights.bold,
          height: 1.5,
        );
}
