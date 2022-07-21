import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleTextStyleShowcase extends StatelessWidget {
  const SampleTextStyleShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DSHeadlineLargeText(
          text: 'Headline Large Text',
        ),
        const DSHeadlineSmallText(
          text: 'Headline Small Text',
        ),
        DSBodyText(
          text: 'Body Text',
          // color: DSColors.extendRedsLipstick,
          // decoration: TextDecoration.underline,
          // fontWeight: DSFontWeights.extraBold,
          // overflow: TextOverflow.fade,
        ),
        DSButtonText(
          text: 'Button Text',
          color: DSColors.neutralDarkCity,
        ),
        DSCaptionText(
          text: 'Caption Large Text',
          // color: DSColors.extendRedsLipstick,
          // fontWeight: DSFontWeights.extraBold,
        ),
        DSCaptionSmallText(
          text: 'Caption Small Text',
          // color: DSColors.extendRedsLipstick,
          // fontWeight: DSFontWeights.extraBold,
        ),
      ],
    );
  }
}
