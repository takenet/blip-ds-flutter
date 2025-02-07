import 'package:flutter/material.dart';

import '../../services/ds_theme.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_icon_button.widget.dart';

class DSCustomRepliesIconButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isVisible;
  final bool isLoading;

  const DSCustomRepliesIconButton({
    super.key,
    required this.onPressed,
    this.isVisible = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) => Visibility(
        visible: isVisible,
        child: DSIconButton(
          isLoading: isLoading,
          onPressed: onPressed,
          icon: Icon(
            DSIcons.message_talk_outline,
            color: DSThemeService.isDarkMode
                ? DSColors.neutralLightSnow
                : DSColors.neutralDarkRooftop,
          ),
        ),
      );
}
