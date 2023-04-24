import 'package:flutter/material.dart';

import '../../../utils/ds_utils.util.dart';
import '../../colors/ds_colors.theme.dart';
import '../utils/ds_font_families.theme.dart';
import '../utils/ds_font_weights.theme.dart';

/// A container that has some default properties which should be extended by others Design System's [TextStyle].
class DSTextStyle extends TextStyle {
  /// Creates a Design System's [TextStyle].
  const DSTextStyle({
    super.fontSize,
    super.fontWeight = DSFontWeights.regular,
    super.fontStyle = FontStyle.normal,
    super.color = DSColors.neutralDarkCity,
    super.decoration,
    super.overflow = TextOverflow.ellipsis,
    super.height,
  }) : super(
          package: DSUtils.packageName,
          fontFamily: DSFontFamilies.nunitoSans,
        );
}
