import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.theme.dart';

/// A Design System's [TextStyle] primarily used by regular subtitles and descriptions.
///
/// This style's font variant is $fs-14-p2.
class DSCaptionTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-14-p2 font variant.
  const DSCaptionTextStyle({
    super.fontWeight = DSFontWeights.regular,
    super.color = DSColors.neutralDarkCity,
  }) : super(
          fontSize: 14,
        );
}
