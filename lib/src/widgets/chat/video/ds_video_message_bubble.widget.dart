import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/chat/ds_video_message_bubble.controller.dart';
import '../../../enums/ds_align.enum.dart';
import '../../../enums/ds_border_radius.enum.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../models/ds_reply_content.model.dart';
import '../../../services/ds_auth.service.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../../utils/ds_utils.util.dart';
import '../../animations/ds_uploading.widget.dart';
import '../../buttons/ds_button.widget.dart';
import '../../texts/ds_caption_text.widget.dart';
import '../../utils/ds_circular_progress.widget.dart';
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

  /// Indicates if the video file is uploading
  final bool isUploading;

  // reply id message
  final DSReplyContent? replyContent;

  /// Title of the video which will be displayed inside the message bubble.
  final String? title;

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
    this.type = 'video/mp4',
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
    this.shouldAuthenticate = false,
    DSMessageBubbleStyle? style,
    this.isUploading = false,
    this.replyContent,
    this.title,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  State<DSVideoMessageBubble> createState() => _DSVideoMessageBubbleState();
}

class _DSVideoMessageBubbleState extends State<DSVideoMessageBubble>
    with AutomaticKeepAliveClientMixin {
  late final DSVideoMessageBubbleController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    if (!widget.isUploading) {
      _controller = DSVideoMessageBubbleController(
        url: widget.url,
        mediaSize: widget.mediaSize,
        httpHeaders:
            widget.shouldAuthenticate ? DSAuthService.httpHeaders : null,
        type: widget.type,
      );
      _isInitialized = true;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final hasText = widget.text?.isNotEmpty ?? false;
    final hasTitle = widget.title?.isNotEmpty ?? false;

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
      defaultMaxSize: DSUtils.bubbleMinSize,
      shouldUseDefaultSize: true,
      replyContent: widget.replyContent,
      align: widget.align,
      borderRadius: widget.borderRadius,
      padding: EdgeInsets.zero,
      style: widget.style,
      child: LayoutBuilder(
        builder: (_, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: DSUtils.bubbleMinSize,
              width: DSUtils.bubbleMinSize,
              child: widget.isUploading
                  ? Stack(
                      children: [
                        Image.file(
                          File(
                            widget.url,
                          ),
                          opacity: const AlwaysStoppedAnimation(.3),
                          width: DSUtils.bubbleMinSize,
                          height: DSUtils.bubbleMinSize,
                          fit: BoxFit.cover,
                        ),
                        const Positioned(
                          bottom: 10.0,
                          right: 10.0,
                          child: DSUploading(),
                        ),
                        const Center(
                          child: Icon(
                            DSIcons.video_outline,
                            color: DSColors.disabledBg,
                            size: 80.0,
                          ),
                        ),
                      ],
                    )
                  : _isInitialized
                      ? Obx(
                          () => _controller.hasError.value
                              ? _buidErrorIcon()
                              : _controller.isLoadingThumbnail.value
                                  ? const SizedBox.shrink()
                                  : _controller.isDownloading.value
                                      ? DSCircularProgress(
                                          currentProgress:
                                              _controller.downloadProgress,
                                          maximumProgress:
                                              _controller.maximumProgress,
                                          foregroundColor: foregroundColor,
                                        )
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
                                                  borderColor:
                                                      buttonBorderColor,
                                                  label: _controller.size(),
                                                  onPressed:
                                                      _controller.downloadVideo,
                                                ),
                                              ),
                                            )
                                          : DSVideoBody(
                                              align: widget.align,
                                              appBarPhotoUri:
                                                  widget.appBarPhotoUri,
                                              appBarText: widget.appBarText,
                                              url: widget.url,
                                              shouldAuthenticate:
                                                  widget.shouldAuthenticate,
                                              thumbnail: _controller
                                                      .isThumbnailUnavailable
                                                      .value
                                                  ? const SizedBox.shrink()
                                                  : Center(
                                                      child: Image.file(
                                                        File(
                                                          _controller
                                                              .thumbnail.value,
                                                        ),
                                                        width: DSUtils
                                                            .bubbleMinSize,
                                                        height: DSUtils
                                                            .bubbleMinSize,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                            ),
                        )
                      : _buidErrorIcon(),
            ),
            if (hasTitle || hasText)
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasTitle)
                        DSCaptionText(
                          widget.title!,
                          color: foregroundColor,
                          isSelectable: true,
                        ),
                      if (hasTitle && hasText)
                        const SizedBox(
                          height: 6.0,
                        ),
                      if (hasText)
                        DSShowMoreText(
                          text: widget.text!,
                          align: widget.align,
                          style: widget.style,
                          maxWidth: constraints.maxWidth,
                        )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buidErrorIcon() => const Icon(
        DSIcons.video_broken_outline,
        size: 80.0,
        color: DSColors.neutralDarkRooftop,
      );
}
