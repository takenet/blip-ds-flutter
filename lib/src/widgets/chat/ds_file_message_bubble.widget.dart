import 'package:blip_ds/src/controllers/chat/ds_file_message_bubble.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../animations/ds_fading_circle_loading.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_small_text.widget.dart';
import '../utils/ds_file_extension_icon.util.dart';
import 'ds_message_bubble.widget.dart';

class DSFileMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String url;
  final int size;
  final String filename;
  final DSFileMessageBubbleController controller;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  /// Creates a Design System's [DSMessageBubble] used on files other than image, audio, or video
  DSFileMessageBubble({
    super.key,
    required this.align,
    required this.url,
    required this.size,
    required this.filename,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        controller = DSFileMessageBubbleController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openFile(filename, url),
      child: DSMessageBubble(
        borderRadius: borderRadius,
        padding: EdgeInsets.zero,
        align: align,
        style: style,
        child: SizedBox(
          height: 80.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 80.0,
      color: DSColors.neutralLightSnow,
      child: Obx(
        () => controller.isDownloading.value
            ? const DSFadingCircleLoading(
                color: DSColors.neutralDarkRooftop,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DSFileExtensionIcon(
                    filename: filename,
                    size: 40.0,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildText() {
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
            ),
            DSCaptionSmallText(
              controller.getFileSize(size),
              color: color,
            )
          ],
        ),
      ),
    );
  }
}
