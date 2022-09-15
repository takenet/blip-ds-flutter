import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function(String) onChanged;
  final TextInputAction textInputAction;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final bool showEmojiButton;

  const DSTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.textInputAction = TextInputAction.send,
    this.maxLines,
    this.textCapitalization = TextCapitalization.sentences,
    this.showEmojiButton = false,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: DSUtils.defaultAnimationDuration,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          border: Border.all(
            width: 1,
            color: DSColors.neutralMediumSilver,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                controller: controller,
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
                textCapitalization: textCapitalization,
                textInputAction: textInputAction,
                maxLines: maxLines,
                onChanged: onChanged,
              ),
            ),
            if (showEmojiButton)
              IconButton(
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
      );
}
