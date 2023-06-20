import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/colors/ds_colors.theme.dart';
import '../../../utils/ds_utils.util.dart';
import '../ds_tertiary_button.widget.dart';

class DSAudioIconButton extends DSTertiaryButton {
  DSAudioIconButton({
    super.key,
    super.onPressed,
    super.isLoading,
  }) : super(
          leadingIcon: SvgPicture.asset(
            'assets/images/microphone.svg',
            package: DSUtils.packageName,
            colorFilter: const ColorFilter.mode(
              DSColors.neutralDarkRooftop,
              BlendMode.srcIn,
            ),
            height: 24.0,
          ),
        );
}
