import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/colors/ds_colors.theme.dart';
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
    this.isEnabled = true,
    this.errorText,
    this.inputFormatters,
  });

  final void Function(String term)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType textInputType;
  final bool isEnabled;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<DSTextFormField> createState() => _DSTextFormFieldState();
}

class _DSTextFormFieldState extends State<DSTextFormField> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
          decoration: BoxDecoration(
            color: widget.isEnabled
                ? DSColors.neutralLightSnow
                : DSColors.neutralLightWhisper,
            border: Border.all(color: _color()),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            keyboardType: widget.textInputType,
            focusNode: focusNode,
            controller: widget.controller,
            onChanged: widget.onChanged,
            style: DSBodyTextStyle(
              color: widget.isEnabled
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralMediumSilver,
            ),
            autofocus: false,
            enabled: widget.isEnabled,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              fillColor: widget.isEnabled
                  ? DSColors.neutralLightSnow
                  : DSColors.neutralLightWhisper,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              labelText: widget.hintText,
              labelStyle: DSCaptionSmallTextStyle(
                fontWeight: DSFontWeights.bold,
                color: widget.isEnabled
                    ? DSColors.neutralMediumCloud
                    : DSColors.neutralMediumSilver,
              ),
              filled: true,
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintStyle: const DSBodyTextStyle(
                color: DSColors.neutralMediumElephant,
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.errorText != null,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                const Icon(
                  DSIcons.error_solid,
                  color: DSColors.extendRedsDelete,
                ),
                const SizedBox(width: 6),
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
    } else if (focusNode.hasFocus) {
      return DSColors.primaryNight;
    } else if (widget.isEnabled) {
      return DSColors.neutralMediumWave;
    } else {
      return DSColors.neutralLightBox;
    }
  }
}
