import 'dart:ui';

import 'package:flutter_svg/svg.dart';

import '../../themes/colors/ds_colors.theme.dart';

class DSSvg extends SvgPicture {
  final Color color;

  DSSvg.asset(
    super.assetName, {
    super.key,
    super.fit,
    super.package,
    super.height = 24.0,
    this.color = DSColors.neutralDarkCity,
  }) : super.asset(
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        );
}
