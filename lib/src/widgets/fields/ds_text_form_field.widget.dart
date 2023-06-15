import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSTextFormField extends StatefulWidget {
  const DSTextFormField({
    super.key,
    required this.textInputType,
    this.onChanged,
    this.controller,
    this.hintText,
    this.isEnabled = true,
    this.errorText,
  });

  final void Function(String term)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType textInputType;
  final bool isEnabled;
  final String? errorText;

  @override
  State<DSTextFormField> createState() => _DSTextFormFieldState();
}

class _DSTextFormFieldState extends State<DSTextFormField> {
  late Color _borderColor;
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _borderColor = _color();
    focusNode.addListener(() {
      setState(() {
        _borderColor = _color();
      });
    });
  }

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
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            keyboardType: widget.textInputType,
            focusNode: focusNode,
            controller: widget.controller,
            onChanged: widget.onChanged,
            style: const DSBodyTextStyle(color: DSColors.neutralDarkCity),
            autofocus: false,
            enabled: widget.isEnabled,
            decoration: InputDecoration(
              fillColor: widget.isEnabled
                  ? DSColors.neutralLightSnow
                  : DSColors.neutralLightWhisper,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              labelText: widget.hintText,
              labelStyle: const DSCaptionSmallTextStyle(
                fontWeight: DSFontWeights.bold,
                color: DSColors.neutralMediumCloud,
              ),
              filled: true,
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
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
    if (focusNode.hasFocus) {
      return DSColors.primaryNight;
    } else if (widget.isEnabled) {
      return DSColors.neutralMediumWave;
    } else if (widget.errorText != null) {
      return DSColors.extendRedsDelete;
    } else {
      return DSColors.neutralLightBox;
    }
  }
}
