import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DSTextFormField extends StatelessWidget {
  DSTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.textInputAction = TextInputAction.send,
    this.maxLines,
    this.textCapitalization = TextCapitalization.sentences,
    this.showEmojiButton = false,
  });

  final TextEditingController controller;
  final String hint;
  final void Function(String) onChanged;
  final TextInputAction textInputAction;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final bool showEmojiButton;

  final hasFocus = false.obs;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => Focus(
        onFocusChange: hasFocus,
        child: Obx(
          () => AnimatedContainer(
            duration: DSUtils.defaultAnimationDuration,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              border: Border.all(
                width: 1,
                color: hasFocus.value ? DSColors.primaryMain : DSColors.neutralMediumSilver,
              ),
            ),
            child: Scrollbar(
              controller: _scrollController,
              radius: const Radius.circular(5),
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
                        style: const DSBodyTextStyle(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: hint,
                          hintStyle: const DSBodyTextStyle(color: DSColors.neutralMediumElephant),
                          isDense: true,
                        ),
                        cursorColor: DSColors.primaryMain,
                        cursorHeight: 20.0,
                        textCapitalization: textCapitalization,
                        textInputAction: textInputAction,
                        maxLines: maxLines,
                        onChanged: onChanged,
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
        ),
      );
}
