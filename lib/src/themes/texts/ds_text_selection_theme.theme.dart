import 'package:flutter/material.dart';

import '../colors/ds_colors.theme.dart';

class DSTextSelectionThemeData extends TextSelectionThemeData {
  DSTextSelectionThemeData()
      : super(
          selectionColor: DSColors.primaryMain.withValues(
            alpha: 0.5,
          ),
          selectionHandleColor: DSColors.primaryDark,
        );
}
