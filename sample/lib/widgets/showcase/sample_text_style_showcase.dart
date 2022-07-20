import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleTextStyleShowcase extends StatelessWidget {
  const SampleTextStyleShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Headline Large Text',
          style: DSHeadlineLargeTextStyle(),
          // style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          'Headline Small Text',
          style: DSHeadlineSmallTextStyle(),
          // style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          'Body Text',
          style: DSBodyTextStyle(),
          // style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          'Button Text',
          style: DSButtonTextStyle(),
          // style: Theme.of(context).textTheme.button,
        ),
        Text(
          'Caption Large Text',
          style: DSCaptionTextStyle(),
          // style: Theme.of(context).textTheme.subtitle1,
        ),
        Text(
          'Caption Small Text',
          style: DSCaptionSmallTextStyle(),
          // style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
