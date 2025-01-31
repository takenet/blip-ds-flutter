import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../blip_ds.dart';

class DSAudioResumeButton extends DSTertiaryButton {
  DSAudioResumeButton({
    super.key,
    super.onPressed,
    super.label,
  }) : super(
          leadingIcon: SvgPicture.asset(
            'assets/images/microphone.svg',
            package: DSUtils.packageName,
            colorFilter: ColorFilter.mode(
              DSThemeService.isDarkMode()
                  ? DSColors.neutralLightSnow
                  : DSColors.neutralDarkRooftop,
              BlendMode.srcIn,
            ),
            height: 24.0,
          ),
        );
}
