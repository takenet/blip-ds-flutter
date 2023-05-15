import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
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
  });

  final void Function(String term)? onChanged;
  final VoidCallback onTap;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool showSuffixIcon;
  final String? hintText;
  final EdgeInsets padding;
  final ScrollPhysics scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          child: SizedBox(
            height: 44.0,
            child: TextField(
              keyboardType: TextInputType.none,
              showCursor: false,
              focusNode: focusNode,
              controller: controller,
              onChanged: onChanged,
              style: const DSBodyTextStyle(color: DSColors.neutralDarkCity),
              autofocus: false,
              decoration: InputDecoration(
                suffixIcon: Visibility(
                  visible: showSuffixIcon,
                  child: const Icon(
                    DSIcons.arrow_down_outline,
                    color: DSColors.neutralMediumCloud,
                  ),
                ),
                fillColor: DSColors.neutralLightSnow,
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
                  borderSide: const BorderSide(
                    color: DSColors.neutralMediumWave,
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
