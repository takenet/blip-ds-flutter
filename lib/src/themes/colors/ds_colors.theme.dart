import 'package:blip_ds/src/themes/colors/ds_linear_gradient.theme.dart';
import 'package:flutter/material.dart';

/// All [Color] constants that are used by this Design System.
abstract class DSColors {
  static const Color primary = Color(0xFF1E6BF1);
  static const Color primaryLight = Color(0xFFB3D4FF);
  static const Color primaryMain = Color(0xFF3F7DE8);
  static const Color primaryNight = Color(0xFF0747A6);
  static const Color primaryDark = Color(0xFF125AD5);
  static const Color primaryGreensMint = Color(0xFF90E6BC);
  static const Color primaryGreensTrue = Color(0xFF21CC79);
  static const Color primaryGreensForest = Color(0xFF0A6045);
  static const Color primaryGreensAligator = Color(0xFF008767);
  static const Color primaryYellowsCorn = Color(0xFFFFF6A8);
  static const Color primaryPinksWatermelon = Color(0xFFFB5A8B);
  static const Color primaryOrangesDoritos = Color(0xFFC64026);
  static const Color primaryPurplesWitch = Color(0xFF9933CC);

  static const Color neutralDarkCity = Color(0xFF202C44);
  static const Color neutralDarkDesk = Color(0xFF3A4A65);
  static const Color neutralDarkRooftop = Color(0xFF505F79);
  static const Color neutralDarkEclipse = Color(0xFF0A0F1A);
  static const Color neutralMediumElephant = Color(0xFF6E7B91);
  static const Color neutralMediumCloud = Color(0xFF8CA0B3);
  static const Color neutralMediumSilver = Color(0xFFB9CBD3);
  static const Color neutralMediumWave = Color(0xFFD2DFE6);
  static const Color neutralLightBox = Color(0xFFE7EDF4);
  static const Color neutralLightWhisper = Color(0xFFF3F6FA);
  static const Color neutralLightSnow = Color(0xFFFFFFFF);

  static const Color illustrationBlueGenie = Color(0xFF80E3EB);
  static const Color illustrationBlueJeans = Color(0xFF212A3C);
  static const Color hoverLight = Color(0xFFD1E3FA);

  static const Color extendBrownsSand = Color(0xFFFFD29E);
  static const Color extendBrownsCheetos = Color(0xFFF6A721);
  static const Color extendRedsLipstick = Color(0xFFA01C2C);
  static const Color extendRedsFlower = Color(0xFFFFA5A5);
  static const Color extendRedsDragon = Color(0xFF6A2026);
  static const Color extendRedsDelete = Color(0xFFFF4C4C);
  static const Color extendGraysElevator = Color(0xFFA7A9AC);
  static const Color extendGraysMoon = Color(0xFFD1D3D4);
  static const Color extendBrownsWood = Color(0xFF845D37);

  static const Color actionColorNegative = Color(0xFFE60F0F);

  static const Color system = Color(0xFFB2DFFD);
  static const Color success = Color(0xFF84EBBC);
  static const Color error = Color(0xFFF99F9F);
  static const Color surface1 = Color(0xFFF6F6F6);
  static const Color surface3 = Color(0xFFC7C7C7);
  static const Color contentDefault = Color(0xFF454545);
  static const Color contentGhost = Color(0xFF949494);


  static const Color disabledText = Color(0xFF637798);
  static const Color disabledBg = Color(0xFFE8F2FF);
  static const Color contentDisable = Color(0xFF636363);
  static const Color border1 = Color(0xFF616161);

  static Gradient gradientOcean = DSLinearGradient(
    colors: const [
      Color(0xFF4F0E87),
      Color(0xFF4786F1),
    ],
    degree: -153.33,
  );
  static Gradient gradientTree = DSLinearGradient(
    colors: const [
      Color(0xFF167491),
      Color(0xFF21CC79),
    ],
    degree: -146.81,
  );
  static Gradient gradientFabulous = DSLinearGradient(
    colors: const [
      Color(0xFF9933CC),
      Color(0xFFFB5A8B),
    ],
    degree: -147.25,
  );
}
