import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../services/ds_theme.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/colors/ds_dark_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../themes/texts/styles/ds_caption_small_text_style.theme.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../texts/ds_caption_small_text.widget.dart';

class DSTextFormField extends StatefulWidget {
  const DSTextFormField({
    super.key,
    required this.textInputType,
    this.onChanged,
    this.controller,
    this.hintText,
    this.labelText,
    this.isEnabled = true,
    this.errorText,
    this.inputFormatters,
  });

  final TextInputType textInputType;
  final void Function(String term)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool isEnabled;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<DSTextFormField> createState() => _DSTextFormFieldState();
}

class _DSTextFormFieldState extends State<DSTextFormField> {
  final Rx<Color> _borderColor = Rx(DSColors.neutralLightBox);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      _borderColor.value = _color();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _borderColor.value = _color();

    return Column(
      children: [
        Obx(
          () => Container(
            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 4.0, 6.0),
            decoration: BoxDecoration(
              color: widget.isEnabled
                  ? DSThemeService.isDarkMode
                      ? DSDarkColors.surface3
                      : DSColors.neutralLightSnow
                  : DSThemeService.isDarkMode
                      ? DSDarkColors.surface1
                      : DSColors.neutralLightWhisper,
              border: Border.all(color: _borderColor.value),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              keyboardType: widget.textInputType,
              focusNode: _focusNode,
              controller: widget.controller,
              onChanged: widget.onChanged,
              style: DSBodyTextStyle(
                color: widget.isEnabled
                    ? DSThemeService.isDarkMode
                        ? DSColors.neutralLightSnow
                        : DSColors.neutralDarkCity
                    : DSColors.neutralMediumSilver,
              ),
              autofocus: false,
              enabled: widget.isEnabled,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                fillColor: widget.isEnabled
                    ? DSThemeService.isDarkMode
                        ? DSDarkColors.surface3
                        : DSColors.neutralLightSnow
                    : DSThemeService.isDarkMode
                        ? DSDarkColors.surface1
                        : DSColors.neutralLightWhisper,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: widget.labelText,
                labelStyle: DSCaptionSmallTextStyle(
                  fontWeight: DSFontWeights.bold,
                  color: widget.isEnabled
                      ? DSThemeService.isDarkMode
                          ? DSColors.neutralLightSnow
                          : DSColors.neutralMediumCloud
                      : DSColors.neutralMediumSilver,
                ),
                filled: true,
                hintText: widget.hintText ?? widget.labelText,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintStyle: const DSBodyTextStyle(
                  color: DSColors.neutralMediumElephant,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.errorText != null,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                const Icon(
                  DSIcons.error_solid,
                  color: DSColors.extendRedsDelete,
                ),
                const SizedBox(width: 6.0),
                DSCaptionSmallText(
                  widget.errorText,
                  color: DSColors.extendRedsDelete,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _color() {
    if (widget.errorText != null) {
      return DSColors.extendRedsDelete;
    } else if (_focusNode.hasFocus) {
      return DSColors.primaryNight;
    } else if (widget.isEnabled) {
      return DSThemeService.isDarkMode
          ? DSDarkColors.surface0
          : DSColors.neutralMediumWave;
    } else {
      return DSThemeService.isDarkMode
          ? DSDarkColors.surface0
          : DSColors.neutralLightBox;
    }
  }
}
