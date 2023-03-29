import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../enums/ds_align.enum.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';

class DSRoundedPlayButton extends InkWell {
  final DSAlign align;
  final void Function() onPressed;

  DSRoundedPlayButton({
    super.key,
    required this.align,
    required this.onPressed,
  }) : super(
          onTap: onPressed,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: align == DSAlign.right
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
              borderRadius: const BorderRadius.all(
                Radius.circular(40.0),
              ),
              border: Border.all(
                width: 1,
                color: align == DSAlign.right
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralMediumCloud,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/play.svg',
                package: DSUtils.packageName,
                color: align == DSAlign.right
                    ? DSColors.neutralLightSnow
                    : DSColors.neutralDarkCity,
                height: 32,
              ),
            ),
          ),
        );
}
