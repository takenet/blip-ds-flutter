import 'package:flutter/material.dart';
import '../../enums/ds_align.enum.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';

class DSPlayButtonRounded extends InkWell {
  DSPlayButtonRounded({
    super.key,
    required final DSAlign align,
    required void Function() onPressed,
  }) : super(
          onTap: onPressed,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: align == DSAlign.right ? DSColors.neutralDarkCity : DSColors.neutralLightSnow,
              borderRadius: const BorderRadius.all(
                Radius.circular(40.0),
              ),
              border: Border.all(
                width: 1,
                color: align == DSAlign.right ? DSColors.neutralDarkCity : DSColors.neutralMediumCloud,
              ),
            ),
            child: Center(
              child: Image.asset(
                align == DSAlign.right
                    ? 'assets/images/play_neutral_light_snow.png'
                    : 'assets/images/play_neutral_dark_rooftop.png',
                height: 33,
                package: DSUtils.packageName,
              ),
            ),
          ),
        );
}
