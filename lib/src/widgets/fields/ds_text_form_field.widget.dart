import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../utils/ds_utils.util.dart';
import 'ds_input_decoration.widget.dart';

class DSTextFormField extends StatelessWidget {
  DSTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    required this.hasFocus,
    this.textInputAction = TextInputAction.send,
    this.onTap,
    this.onTapOutside,
    this.maxLines,
    this.textCapitalization = TextCapitalization.sentences,
    this.showEmojiButton = false,
    this.obscureText = false,
    this.focusNode,
    this.isEnabled = true,
  });

  final TextEditingController controller;
  final String hint;
  final void Function(String) onChanged;
  final TextInputAction textInputAction;
  final VoidCallback? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final bool showEmojiButton;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool isEnabled;
  final bool hasFocus;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => DSInputDecoration(
        hasFocus: focusNode?.hasFocus,
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 6.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: Scrollbar(
          controller: _scrollController,
          radius: const Radius.circular(5),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 6.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 100.0,
                    ),
                    child: TextFormField(
                      controller: controller,
                      scrollController: _scrollController,
                      enabled: isEnabled,
                      obscureText: obscureText,
                      focusNode: focusNode,
                      style: const DSBodyTextStyle(),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: hint,
                        hintStyle: const DSBodyTextStyle(
                          color: DSColors.neutralMediumSilver,
                        ),
                      ),
                      cursorColor: DSColors.primaryMain,
                      cursorHeight: 20.0,
                      textCapitalization: textCapitalization,
                      textInputAction: textInputAction,
                      maxLines: obscureText ? 1 : maxLines,
                      onChanged: onChanged,
                      onTap: onTap,
                      onTapOutside: onTapOutside,
                    ),
                  ),
                ),
                if (showEmojiButton)
                  IconButton(
                    /// TODO: Implement to open emoji keyboard!!
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    splashRadius: 15,
                    constraints: const BoxConstraints(),
                    icon: Image.asset(
                      'assets/images/emoji.png',
                      package: DSUtils.packageName,
                      height: 20.5,
                      width: 20.5,
                    ),
                  )
              ],
            ),
          ),
        ),
      );
}
