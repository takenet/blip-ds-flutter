import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.theme.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.theme.dart';

/// A Design System's [TextStyle] primarily used by buttons.
class DSButtonTextStyle extends DSTextStyle {
  const DSButtonTextStyle({
    super.color = DSColors.neutralLightSnow,
  }) : super(
          fontSize: 16,
          fontWeight: DSFontWeights.bold,
        );
}
