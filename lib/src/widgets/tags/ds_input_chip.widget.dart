import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '/src/themes/colors/ds_colors.theme.dart';
import '/src/themes/icons/ds_icons.dart';
import '/src/themes/texts/styles/ds_body_text_style.theme.dart';
import '/src/widgets/tags/tag_editor/tag_editor.dart';
import '/src/widgets/texts/ds_headline_small_text.widget.dart';
import '/src/widgets/utils/ds_chip.widget.dart';
import '../buttons/ds_icon_button.widget.dart';

class DSInputChip extends StatefulWidget {
  final RxList<String> values;
  final TextEditingController controller;
  final void Function(String text)? onTextChanged;
  final void Function(int index)? onDeleted;
  final String? hintText;
  final ScrollController? scrollController;

  const DSInputChip({
    Key? key,
    required this.values,
    required this.controller,
    this.hintText,
    this.onTextChanged,
    this.onDeleted,
    this.scrollController,
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
  void dispose() {
    super.dispose();

    widget.controller.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TagEditor(
        scrollController: widget.scrollController,
        tagSpacing: 5.0,
        minTextFieldWidth: 40.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
            bottom: 10.0,
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
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: SizedBox(
        height: 32.0,
        child: DSChip(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          textPadding: const EdgeInsets.only(
            left: 12.0,
            right: 8.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          text: DSHeadlineSmallText(widget.values[index]),
          background: DSColors.primaryLight,
          trailingIcon: SizedBox(
            child: DSIconButton(
              size: 32.0,
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
