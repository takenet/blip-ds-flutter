import 'package:blip_ds/src/utils/ds_utils.util.dart';
import 'package:flutter/material.dart';

class DSPlayButtonWidget extends StatelessWidget {
  final DSPlayButtonIconColor icon;
  final VoidCallback onPressed;

  const DSPlayButtonWidget(
      {Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 1,
      icon: icon == DSPlayButtonIconColor.neutralDarkRooftop
          ? Image.asset(
              'assets/images/play_neutral_light_snow.png',
              package: DSUtils.packageName,
            )
          : Image.asset(
              'assets/images/play_neutral_dark_rooftop.png',
              package: DSUtils.packageName,
            ),
      iconSize: 42.0,
      onPressed: onPressed,
    );
  }
}

enum DSPlayButtonIconColor { neutralDarkRooftop, neutralLightSnow }
