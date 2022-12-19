import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';

/// A Design System's [TextStyle] primarily used by small titles.
///
/// This style's font variant is $fs-16-p1.
class DSHeadlineSmallTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-16-p1 font variant.
  const DSHeadlineSmallTextStyle({
    super.color = DSColors.neutralDarkCity,
  }) : super(
          fontSize: 16.0,
          fontWeight: DSFontWeights.bold,
          height: 1.5,
        );
}
