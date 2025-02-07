import 'package:flutter/material.dart';

import '../../services/ds_theme.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/colors/ds_dark_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';

class DSSearchInput extends StatelessWidget {
  const DSSearchInput({
    super.key,
    required this.onSearch,
    required this.onClear,
    this.focusNode,
    this.controller,
    this.showSuffixIcon = true,
    this.hintText,
    this.iconBackgroundColor = DSColors.disabledBg,
    this.iconForegroundColor = DSColors.primaryNight,
    this.enabled,
  });

  final void Function(String term) onSearch;
  final void Function() onClear;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool showSuffixIcon;
  final String? hintText;
  final Color iconBackgroundColor;
  final Color iconForegroundColor;
  final bool? enabled;

  // TODO: check if can use DSTextField or DSInputContainer
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: TextField(
        cursorColor: DSColors.primaryMain,
        enabled: enabled ?? true,
        focusNode: focusNode,
        controller: controller,
        onChanged: onSearch,
        style: DSBodyTextStyle(
            color: DSThemeService.isDarkMode
                ? DSColors.neutralLightSnow
                : DSColors.neutralDarkCity),
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: Visibility(
            visible: showSuffixIcon,
            child: IconButton(
              splashRadius: 1,
              onPressed: () => onClear(),
              icon: const Icon(
                DSIcons.error_solid,
                color: DSColors.neutralMediumCloud,
              ),
            ),
          ),
          fillColor: DSThemeService.isDarkMode
              ? DSDarkColors.surface3
              : DSColors.neutralLightSnow,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 25.0,
            minHeight: 25.0,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Icon(
                DSIcons.search_outline,
                size: 21.0,
                color: iconForegroundColor,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: DSColors.primaryNight,
              width: 1.0,
            ),
          ),
          disabledBorder: _getBorder(),
          enabledBorder: _getBorder(),
          filled: true,
          hintText: hintText,
          hintStyle: const DSBodyTextStyle(
            color: DSColors.neutralMediumElephant,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _getBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: DSThemeService.isDarkMode
              ? DSDarkColors.surface0
              : DSColors.neutralMediumWave,
          width: 1.0,
        ),
      );
}
