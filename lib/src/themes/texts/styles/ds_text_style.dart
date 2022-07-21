import 'package:blip_ds/src/themes/texts/utils/ds_font_families.dart';
import 'package:blip_ds/src/utils/ds_utils.dart';
import 'package:flutter/material.dart';

class DSTextStyle extends TextStyle {
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
