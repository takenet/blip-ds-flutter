import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';

/// A Design System's [TextStyle] primarily used by small subtitles and descriptions.
///
/// This style's font variant is $fs-12-p3.
class DSCaptionSmallTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-12-p3 font variant.
  const DSCaptionSmallTextStyle({
    super.fontWeight = DSFontWeights.regular,
    super.color = DSColors.neutralDarkCity,
  }) : super(
          fontSize: 12.0,
          height: 1.66,
        );
}
