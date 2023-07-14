import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../enums/ds_input_container_shape.enum.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../utils/ds_utils.util.dart';
import '../texts/ds_caption_small_text.widget.dart';
import 'ds_input_container.widget.dart';

class DSTextField extends StatefulWidget {
  const DSTextField({
    super.key,
    required this.hint,
    this.controller,
    this.onChanged,
    this.textInputAction = TextInputAction.send,
    this.onTap,
    this.onTapOutside,
    this.maxLines,
    this.textCapitalization = TextCapitalization.sentences,
    this.showEmojiButton = false,
    this.obscureText = false,
    this.focusNode,
    this.isEnabled = true,
    this.shape = DSInputContainerShape.rectangle,
    this.errorText,
    this.textInputType,
  });

  final TextEditingController? controller;
  final String hint;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final VoidCallback? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final bool showEmojiButton;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool isEnabled;
  final DSInputContainerShape shape;
  final String? errorText;
  final TextInputType? textInputType;

  @override
  State<DSTextField> createState() => _DSTextFieldState();
}

class _DSTextFieldState extends State<DSTextField> {
  final _scrollController = ScrollController();
  final hasFocus = RxBool(false);

  @override
  Widget build(BuildContext context) => Obx(
        () => Focus(
          focusNode: widget.focusNode,
          onFocusChange: hasFocus,
          child: Column(
            children: [
              DSInputContainer(
                hasError: widget.errorText?.isNotEmpty ?? false,
                shape: widget.shape,
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
                        _buildTextField(),
                        _buildEmojiButton(),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.errorText?.isNotEmpty ?? false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      const Icon(
                        DSIcons.error_solid,
                        color: DSColors.extendRedsDelete,
                      ),
                      const SizedBox(width: 6.0),
                      Flexible(
                        child: DSCaptionSmallText(
                          widget.errorText,
                          color: DSColors.extendRedsDelete,
                          overflow: TextOverflow.visible,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildTextField() => Flexible(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100.0,
          ),
          child: TextField(
            keyboardType: widget.textInputType,
            controller: widget.controller,
            scrollController: _scrollController,
            enabled: widget.isEnabled,
            obscureText: widget.obscureText,
            style: const DSBodyTextStyle(),
            cursorColor: DSColors.primaryMain,
            cursorHeight: 20.0,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside,
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
          ),
        ),
      );

  Widget _buildEmojiButton() => Visibility(
        visible: widget.showEmojiButton,
        child: IconButton(
          /// TODO: Implement to open emoji keyboard!!
          onPressed: () {},
          padding: EdgeInsets.zero,
          splashRadius: 15.0,
          constraints: const BoxConstraints(),
          icon: Image.asset(
            'assets/images/emoji.png',
            package: DSUtils.packageName,
            height: 20.5,
            width: 20.5,
          ),
        ),
      );
}
