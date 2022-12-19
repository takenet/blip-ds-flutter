import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';

/// A Design System's [TextStyle] primarily used by large titles.
///
/// This style's font variant is $fs-20-h4.
class DSHeadlineLargeTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-20-h4 font variant.
  const DSHeadlineLargeTextStyle()
      : super(
          fontSize: 20.0,
          fontWeight: DSFontWeights.bold,
          color: DSColors.neutralDarkCity,
          height: 1.4,
        );
}
