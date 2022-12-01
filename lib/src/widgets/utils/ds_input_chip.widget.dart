import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:super_tag_editor/tag_editor.dart';

class DSInputChip extends StatefulWidget {
  final RxList<String> values;
  final TextEditingController controller;
  final void Function(String text)? onTextChanged;
  final void Function(int index)? onDeleted;
  final String? hintText;

  const DSInputChip({
    Key? key,
    required this.values,
    this.hintText,
    this.onTextChanged,
    required this.controller,
    this.onDeleted,
  }) : super(key: key);

  @override
  State<DSInputChip> createState() => _DSInputChipState();
}

class _DSInputChipState extends State<DSInputChip> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.onTextChanged != null) {
        widget.onTextChanged?.call(widget.controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TagEditor(
        tagSpacing: 5.0,
        minTextFieldWidth: 40.0,
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0),
        borderSize: 1.0,
        borderRadius: 8.0,
        enableBorderColor: DSColors.neutralMediumWave,
        focusedBorderColor: DSColors.primaryMain,
        textStyle: const DSBodyTextStyle(),
        controller: widget.controller,
        length: widget.values.length,
        delimiters: const [],
        hasAddButton: false,
        inputDecoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            bottom: 8.0,
            left: 4.0,
          ),
          border: InputBorder.none,
          hintText: widget.values.isEmpty ? widget.hintText : '',
        ),
        tagBuilder: (_, index) => _buildChip(index),
        suggestionBuilder: (_, __, ___) => const SizedBox.shrink(),
        findSuggestions: (_) => [],
        onTagChanged: (_) {},
      ),
    );
  }

  Widget _buildChip(final int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        height: 32.0,
        child: DSChip(
          textPadding: const EdgeInsets.only(left: 10.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          text: DSHeadlineSmallText(widget.values[index]),
          background: DSColors.primaryLight,
          deleteIcon: SizedBox(
            width: 35.0,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 20,
              icon: Icon(
                DSIcons.error_solid,
                color: DSColors.neutralDarkCity.withOpacity(0.6),
              ),
              onPressed: () => widget.onDeleted?.call(index),
            ),
          ),
        ),
      ),
    );
  }
}
