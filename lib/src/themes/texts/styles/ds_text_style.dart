import 'package:blip_ds/src/themes/texts/utils/ds_font_families.dart';
import 'package:blip_ds/src/utils/ds_utils.dart';
import 'package:flutter/material.dart';

class DSTextStyle extends TextStyle {
  const DSTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    TextOverflow? overflow = TextOverflow.ellipsis,
  }) : super(
          package: DSUtils.packageName,
          fontFamily: DSFontFamilies.nunitoSans,
          overflow: overflow,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
        );
}
