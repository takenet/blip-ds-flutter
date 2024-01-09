import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleUserAvatarShowcase extends StatelessWidget {
  const SampleUserAvatarShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          radius: 12.0,
          textStyle: const DSCaptionSmallTextStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          radius: 16.0,
          textStyle: const DSCaptionTextStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          radius: 12.0,
          textStyle: const DSBodyTextStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          textStyle: const DSHeadlineLargeTextStyle(
            color: DSColors.illustrationBlueGenie,
          ),
          backgroundColor: DSColors.contentGhost,
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          radius: 40.0,
          textStyle: const DSHeadlineExtraLargeTextStyle(
            color: DSColors.extendRedsLipstick,
          ),
          backgroundColor: DSColors.extendBrownsCheetos,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
