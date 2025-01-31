import 'package:flutter/material.dart';

import '../../services/ds_theme.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/colors/ds_dark_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';

class DSSelectInput extends StatelessWidget {
  const DSSelectInput({
    super.key,
    this.onChanged,
    required this.onTap,
    this.focusNode,
    this.controller,
    this.showSuffixIcon = true,
    this.hintText,
    this.padding = EdgeInsets.zero,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.textInputType = TextInputType.none,
    this.showCursor = false,
    this.absorbing = true,
  });

  final void Function(String term)? onChanged;
  final VoidCallback onTap;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool showSuffixIcon;
  final String? hintText;
  final EdgeInsets padding;
  final ScrollPhysics scrollPhysics;
  final TextInputType textInputType;
  final bool showCursor;
  final bool absorbing;

  // TODO: check if can use DSTextField or DSInputContainer
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          absorbing: absorbing,
          child: SizedBox(
            height: 44.0,
            child: TextField(
              keyboardType: textInputType,
              showCursor: showCursor,
              focusNode: focusNode,
              controller: controller,
              onChanged: onChanged,
              style: DSBodyTextStyle(
                color: DSThemeService.isDarkMode()
                    ? DSColors.neutralLightSnow
                    : DSColors.neutralDarkCity,
              ),
              autofocus: false,
              decoration: InputDecoration(
                suffixIcon: Visibility(
                  visible: showSuffixIcon,
                  child: const Icon(
                    DSIcons.arrow_down_outline,
                    color: DSColors.neutralMediumCloud,
                  ),
                ),
                fillColor: DSThemeService.isDarkMode()
                    ? DSDarkColors.surface3
                    : DSColors.neutralLightSnow,
                contentPadding: const EdgeInsets.all(10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: DSColors.primaryNight,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: DSThemeService.isDarkMode()
                        ? DSDarkColors.surface0
                        : DSColors.neutralMediumWave,
                    width: 1.0,
                  ),
                ),
                filled: true,
                hintText: hintText,
                hintStyle: const DSBodyTextStyle(
                  color: DSColors.neutralMediumElephant,
                ),
              ),
              scrollPhysics: scrollPhysics,
            ),
          ),
        ),
      ),
    );
  }
}
