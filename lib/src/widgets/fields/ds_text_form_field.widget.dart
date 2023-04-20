import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../utils/ds_utils.util.dart';
import 'ds_input_decoration.widget.dart';

class DSTextFormField extends StatefulWidget {
  const DSTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
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

  @override
  State<DSTextFormField> createState() => _DSTextFormFieldState();
}

class _DSTextFormFieldState extends State<DSTextFormField> {
  final _scrollController = ScrollController();
  final hasFocus = RxBool(false);

  @override
  Widget build(BuildContext context) => Obx(
        () => Focus(
          focusNode: widget.focusNode,
          onFocusChange: hasFocus,
          child: DSInputDecoration(
            hasFocus: hasFocus.value,
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
                          controller: widget.controller,
                          scrollController: _scrollController,
                          enabled: widget.isEnabled,
                          obscureText: widget.obscureText,
                          style: const DSBodyTextStyle(),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: widget.hint,
                            hintStyle: const DSBodyTextStyle(
                              color: DSColors.neutralMediumSilver,
                            ),
                          ),
                          cursorColor: DSColors.primaryMain,
                          cursorHeight: 20.0,
                          textCapitalization: widget.textCapitalization,
                          textInputAction: widget.textInputAction,
                          maxLines: widget.obscureText ? 1 : widget.maxLines,
                          onChanged: widget.onChanged,
                          onTap: widget.onTap,
                          onTapOutside: widget.onTapOutside,
                        ),
                      ),
                    ),
                    if (widget.showEmojiButton)
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
          ),
        ),
      );
}
