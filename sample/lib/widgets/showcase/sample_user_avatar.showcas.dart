import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleUserAvatarShowcase extends StatelessWidget {
  const SampleUserAvatarShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSHeadlineLargeText(
          'Headline Large Text',
        ),
        const SizedBox(
          height: 15,
        ),
        DSHeadlineExtraLargeText(
          'Headline EXTRA LARGE Text',
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          textStyle: const DSHeadlineLargeTextStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          textStyle: const DSHeadlineExtraLargeTextStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
