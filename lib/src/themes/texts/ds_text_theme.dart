import 'package:blip_ds/src/themes/texts/styles/ds_body_text_style.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_button_text_style.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_caption_small_text_style.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_caption_text_style.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_headline_large_text_style.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_headline_small_text_style.dart';
import 'package:flutter/material.dart';

class DSTextTheme extends TextTheme {
  const DSTextTheme()
      : super(
          headline1: const DSHeadlineLargeTextStyle(),
          headline2: const DSHeadlineSmallTextStyle(),
          bodyText1: const DSBodyTextStyle(),
          button: const DSButtonTextStyle(),
          subtitle1: const DSCaptionTextStyle(),
          subtitle2: const DSCaptionSmallTextStyle(),
        );
}
