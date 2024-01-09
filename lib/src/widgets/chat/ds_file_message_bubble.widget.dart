import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../controllers/chat/ds_file_message_bubble.controller.dart';
import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../services/ds_auth.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../animations/ds_fading_circle_loading.widget.dart';
import '../animations/ds_uploading.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_small_text.widget.dart';
import '../utils/ds_file_extension_icon.util.dart';
import 'ds_message_bubble.widget.dart';
import 'ds_show_more_text.widget.dart';

class DSFileMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String url;
  final String? text;
  final int size;
  final String filename;
  final DSFileMessageBubbleController controller;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final bool shouldAuthenticate;
  final bool isUploading;
  final DSReplyContent? replyContent;

  /// Creates a Design System's [DSMessageBubble] used on files other than image, audio, or video
  DSFileMessageBubble({
    super.key,
    required this.align,
    required this.url,
    required this.size,
    required this.filename,
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
    this.shouldAuthenticate = false,
    DSMessageBubbleStyle? style,
    this.isUploading = false,
    this.replyContent,
  })  : style = style ?? DSMessageBubbleStyle(),
        controller = DSFileMessageBubbleController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => !isUploading
          ? controller.openFile(
              url: url,
              httpHeaders:
                  shouldAuthenticate ? DSAuthService.httpHeaders : null,
            )
          : null,
      child: Opacity(
        opacity: !isUploading ? 1 : .5,
        child: DSMessageBubble(
          replyContent: replyContent,
          borderRadius: borderRadius,
          padding: EdgeInsets.zero,
          align: align,
          style: style,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIcon(),
                  _buildTitle(),
                ],
              ),
              if (text?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: LayoutBuilder(
                    builder: (_, constraints) => DSShowMoreText(
                      text: text!,
                      maxWidth: constraints.maxWidth,
                      align: align,
                      style: style,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 80.0,
      height: 80.0,
      color: DSColors.neutralLightSnow,
      child: Obx(
        () => controller.isDownloading.value
            ? const DSFadingCircleLoading(
                color: DSColors.neutralDarkRooftop,
              )
            : !isUploading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DSFileExtensionIcon(
                        filename: filename,
                        size: 40.0,
                      ),
                    ],
                  )
                : const DSUploading(
                    color: DSColors.neutralDarkRooftop,
                  ),
      ),
    );
  }

  Widget _buildTitle() {
    final color = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        constraints: const BoxConstraints(
          minWidth: 160.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DSBodyText(
              filename,
              color: color,
              textAlign: TextAlign.center,
              isSelectable: true,
              shouldLinkify: false,
            ),
            Visibility(
              visible: size > 0,
              child: DSCaptionSmallText(
                controller.getFileSize(size),
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
