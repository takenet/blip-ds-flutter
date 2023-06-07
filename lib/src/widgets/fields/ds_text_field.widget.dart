import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSTextField extends StatefulWidget {
  const DSTextField({
    super.key,
    required this.textInputType,
    this.onChanged,
    this.controller,
    this.hintText,
    this.isEnabled = true,
    this.isError = false,
  });

  final void Function(String term)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType textInputType;
  final bool isEnabled;
  final bool isError;

  @override
  State<DSTextField> createState() => _DSTextFieldState();
}

class _DSTextFieldState extends State<DSTextField> {
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
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
      decoration: BoxDecoration(
        color: widget.isEnabled
            ? DSColors.neutralLightSnow
            : DSColors.neutralLightWhisper,
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        keyboardType: TextInputType.name,
        focusNode: focusNode,
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: const DSBodyTextStyle(color: DSColors.neutralDarkCity),
        autofocus: false,
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
    );
  }

  Color _color() {
    if (focusNode.hasFocus) {
      return DSColors.primaryNight;
    } else if (widget.isEnabled) {
      return DSColors.neutralMediumWave;
    } else if (widget.isError) {
      return DSColors.extendRedsDragon;
    } else {
      return DSColors.neutralLightBox;
    }
  }
}
