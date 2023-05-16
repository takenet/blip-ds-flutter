import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSSearchInput extends StatelessWidget {
  const DSSearchInput({
    super.key,
    required this.onSearch,
    required this.onClear,
    this.focusNode,
    this.controller,
    this.showSuffixIcon = true,
    this.hintText,
    this.color = DSColors.disabledBg,
  });

  final void Function(String term) onSearch;
  final void Function() onClear;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool showSuffixIcon;
  final String? hintText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onSearch,
        style: const DSBodyTextStyle(color: DSColors.neutralDarkCity),
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
          fillColor: DSColors.neutralLightSnow,
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
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: const Icon(
                DSIcons.search_outline,
                size: 21.0,
                color: DSColors.primaryNight,
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
      ),
    );
  }
}
