import 'package:flutter/material.dart';

import '../themes/colors/ds_colors.theme.dart';

abstract class DSThemeService {
  static ThemeMode _themeMode = ThemeMode.light;

  static void setThemeMode(final ThemeMode themeMode) => _themeMode = themeMode;

  static bool get isDarkMode => _themeMode == ThemeMode.dark;

  static Color get foregoundColor => _themeMode == ThemeMode.dark
      ? DSColors.neutralLightSnow
      : DSColors.neutralDarkCity;
}
