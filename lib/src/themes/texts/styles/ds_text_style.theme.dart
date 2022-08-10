import 'package:blip_ds/src/themes/texts/utils/ds_font_families.theme.dart';
import 'package:blip_ds/src/utils/ds_utils.util.dart';
import 'package:flutter/material.dart';

/// A container that has some default properties which should be extended by others Design System's [TextStyle].
class DSTextStyle extends TextStyle {
  /// Creates a Design System's [TextStyle].
  const DSTextStyle({
    super.fontSize,
    super.fontWeight,
    super.color,
    super.decoration,
    super.overflow = TextOverflow.ellipsis,
  }) : super(
          package: DSUtils.packageName,
          fontFamily: DSFontFamilies.nunitoSans,
        );
}
