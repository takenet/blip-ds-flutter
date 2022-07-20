import 'package:blip_ds/src/themes/colors/ds_colors.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.dart';
import 'package:blip_ds/src/themes/texts/utils/ds_font_weights.dart';

/// Page or modal large title.
class DSHeadlineLargeTextStyle extends DSTextStyle {
  const DSHeadlineLargeTextStyle()
      : super(
          fontSize: 20,
          fontWeight: DSFontWeights.bold,
          color: DSColors.neutralDarkCity,
        );
}
