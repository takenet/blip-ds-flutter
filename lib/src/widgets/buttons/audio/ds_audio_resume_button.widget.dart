import 'package:blip_ds/blip_ds.dart';
import 'package:flutter_svg/svg.dart';

class DSAudioResumeButton extends DSTertiaryButton {
  DSAudioResumeButton({
    super.key,
    super.onPressed,
    super.label,
  }) : super(
          leadingIcon: SvgPicture.asset(
            'assets/images/microphone.svg',
            package: DSUtils.packageName,
            color: DSColors.neutralDarkRooftop,
            height: 24.0,
          ),
        );
}
