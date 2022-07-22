import 'package:blip_ds/src/themes/colors/ds_colors.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.dart';

/// Buttons
class DSButtonTextStyle extends DSTextStyle {
  const DSButtonTextStyle({
    super.color = DSColors.neutralLightSnow,
  }) : super(
          fontSize: 16,
          fontWeight: DSFontWeights.bold,
        );
}
