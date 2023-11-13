import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/chat/ds_video_message_bubble.controller.dart';
import '../../../enums/ds_align.enum.dart';
import '../../../enums/ds_border_radius.enum.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../services/ds_auth.service.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../buttons/ds_button.widget.dart';
import '../../texts/ds_caption_small_text.widget.dart';
import '../ds_message_bubble.widget.dart';
import '../ds_show_more_text.widget.dart';
import 'ds_video_body.widget.dart';

class DSVideoMessageBubble extends StatefulWidget {
  /// Aligns the card to the right or left according to the value assigned to [align] which can be [DSAlign.right] or [DSAlign.left].
  ///
  final DSAlign align;

  /// URL of the video that will be played when clicking on the card
  final String url;

  /// Border to adjust when widget is used in grouping
  final List<DSBorderRadius> borderRadius;

  /// Text associated with the video context to be shown below thumbnail.
  final String? text;

  /// AppBar title above the video screen that also serves to close, returning to the previous screen.
  final String appBarText;

  /// AppBar avatar uri.
  final Uri? appBarPhotoUri;

  /// Style for bubble
  final DSMessageBubbleStyle style;

  /// The video size
  final int mediaSize;

  /// The video type
  final String type;

  /// Indicates if the HTTP Requests should be authenticated or not.
  final bool shouldAuthenticate;

  /// Upload content
  final Future? upload;

  /// Card for the purpose of triggering a video to play.
  ///
  /// This widget is intended to display a video card from a url passed in the [url] parameter.
  /// The card can be positioned to the right or to the left by the [align] parameter.
  /// The card may also contain a title and text referring to the context of the video to be played.
  DSVideoMessageBubble({
    super.key,
    required this.align,
    required this.url,
    required this.appBarText,
    required this.mediaSize,
    this.appBarPhotoUri,
    this.upload,
    this.type = 'video/mp4',
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
    this.shouldAuthenticate = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  State<DSVideoMessageBubble> createState() => _DSVideoMessageBubbleState();
}

class _DSVideoMessageBubbleState extends State<DSVideoMessageBubble>
    with AutomaticKeepAliveClientMixin {
  late final DSVideoMessageBubbleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DSVideoMessageBubbleController(
      url: widget.url,
      mediaSize: widget.mediaSize,
      httpHeaders: widget.shouldAuthenticate ? DSAuthService.httpHeaders : null,
      type: widget.type,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final foregroundColor = widget.style.isLightBubbleBackground(widget.align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    final buttonBorderColor = widget.style.isLightBubbleBackground(widget.align)
        ? DSColors.primaryNight
        : DSColors.neutralLightSnow;

    final buttonForegroundColor =
        widget.style.isLightBubbleBackground(widget.align)
            ? DSColors.primaryNight
            : DSColors.neutralLightSnow;

    final buttonBackgroundColor =
        widget.style.isLightBubbleBackground(widget.align)
            ? DSColors.neutralLightSnow
            : DSColors.neutralDarkCity;

    return DSMessageBubble(
      align: widget.align,
      borderRadius: widget.borderRadius,
      padding: EdgeInsets.zero,
      style: widget.style,
      child: LayoutBuilder(
        builder: (_, constraints) => FutureBuilder(
          future: widget.upload,
          builder: (_, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => SizedBox(
                    height: 240,
                    width: 240,
                    child: widget.upload == null || snapshot.hasData
                        ? _controller.hasError.value
                            ? const Icon(
                                DSIcons.video_broken_outline,
                                size: 80.0,
                                color: DSColors.neutralDarkRooftop,
                              )
                            : _controller.isDownloading.value
                                ? _buildDownloadProgress(foregroundColor)
                                : _controller.thumbnail.isEmpty
                                    ? Center(
                                        child: SizedBox(
                                          height: 40,
                                          child: DSButton(
                                            leadingIcon: const Icon(
                                              DSIcons.download_outline,
                                              size: 20,
                                            ),
                                            backgroundColor:
                                                buttonBackgroundColor,
                                            foregroundColor:
                                                buttonForegroundColor,
                                            borderColor: buttonBorderColor,
                                            label: _controller.size(),
                                            onPressed:
                                                _controller.downloadVideo,
                                          ),
                                        ),
                                      )
                                    : DSVideoBody(
                                        align: widget.align,
                                        appBarPhotoUri: widget.appBarPhotoUri,
                                        appBarText: widget.appBarText,
                                        url: widget.url,
                                        shouldAuthenticate:
                                            widget.shouldAuthenticate,
                                        thumbnail: Center(
                                          child: Image.file(
                                            File(
                                              _controller.thumbnail.value,
                                            ),
                                            width: 240,
                                            height: 240,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                        : const CircularProgressIndicator(),
                  ),
                ),
                if (widget.text?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: DSShowMoreText(
                      text: widget.text!,
                      align: widget.align,
                      style: widget.style,
                      maxWidth: constraints.maxWidth,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDownloadProgress(final Color foregroundColor) {
    final double percent = _controller.maximumProgress.value > 0
        ? _controller.downloadProgress.value / _controller.maximumProgress.value
        : 0;

    return AnimatedOpacity(
      opacity: _controller.maximumProgress.value > 0 ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: foregroundColor,
              backgroundColor: Colors.grey,
              value: percent,
            ),
          ),
          DSCaptionSmallText(
            _controller.getDownloadProgress(),
            color: foregroundColor,
          )
        ],
      ),
    );
  }
}
