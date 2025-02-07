import 'package:flutter/material.dart';

import '../../services/ds_theme.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/colors/ds_dark_colors.theme.dart';

class DSDivider extends Divider {
  DSDivider({
    super.key,
    super.thickness = 1.0,
    super.height = 1.0,
    Color? color,
  }) : super(
          color: color ??
              (DSThemeService.isDarkMode
                  ? DSDarkColors.surface1
                  : DSColors.neutralMediumWave),
        );
}
