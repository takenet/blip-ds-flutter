import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_file_message_bubble.controller.dart';
import 'package:blip_ds/src/widgets/loading/ds_fading_circle_loading.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DSFileMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String url;
  final int size;
  final String filename;
  final DSFileMessageBubbleController controller;

  /// Creates a Design System's [DSMessageBubble] used on files other than image, audio, or video
  DSFileMessageBubble({
    super.key,
    required this.align,
    required this.url,
    required this.size,
    required this.filename,
  }) : controller = DSFileMessageBubbleController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openFile(filename, url),
      child: DSMessageBubble(
        padding: EdgeInsets.zero,
        align: align,
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
                  Image.asset(
                    controller.getAsset(filename),
                    height: 42.0,
                    package: DSUtils.packageName,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/file-default.png',
                      package: DSUtils.packageName,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget _buildText() {
    final color = align == DSAlign.right
        ? DSColors.neutralLightSnow
        : DSColors.neutralDarkCity;

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
              text: filename,
              color: color,
              textAlign: TextAlign.center,
            ),
            DSCaptionSmallText(
              text: controller.getFileSize(size),
              color: color,
            )
          ],
        ),
      ),
    );
  }
}
