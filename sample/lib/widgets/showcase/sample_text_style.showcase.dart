import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleTextStyleShowcase extends StatelessWidget {
  const SampleTextStyleShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSHeadlineLargeText(
          'Headline Large Text',
        ),
        DSHeadlineSmallText(
          'Headline Small Text',
        ),
        DSBodyText(
          'Body Text',
          // color: DSColors.extendRedsLipstick,
          // decoration: TextDecoration.underline,
          // fontWeight: DSFontWeights.extraBold,
          // overflow: TextOverflow.fade,
        ),
        DSButtonText(
          'Button Text',
          color: DSColors.neutralDarkCity,
        ),
        DSCaptionText(
          'Caption Large Text',
          // color: DSColors.extendRedsLipstick,
          // fontWeight: DSFontWeights.extraBold,
        ),
        DSCaptionSmallText(
          'Caption Small Text',
          // color: DSColors.extendRedsLipstick,
          // fontWeight: DSFontWeights.extraBold,
        ),
      ],
    );
  }
}
