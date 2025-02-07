import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

import '../../../services/ds_theme.service.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../utils/ds_utils.util.dart';
import '../ds_tertiary_button.widget.dart';

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
              DSThemeService.isDarkMode
                  ? DSColors.neutralLightSnow
                  : DSColors.neutralDarkRooftop,
              BlendMode.srcIn,
            ),
            height: 24.0,
          ),
        );
}
