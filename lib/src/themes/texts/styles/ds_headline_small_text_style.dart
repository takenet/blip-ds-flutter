import 'package:blip_ds/src/themes/colors/ds_colors.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.dart';

/// A Design System's [TextStyle] primarily used by small titles.
class DSHeadlineSmallTextStyle extends DSTextStyle {
  const DSHeadlineSmallTextStyle()
      : super(
          fontSize: 16,
          fontWeight: DSFontWeights.bold,
          color: DSColors.neutralDarkCity,
        );
}
