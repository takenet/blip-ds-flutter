import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/chat/ds_video_message_bubble.controller.dart';
import '../../../enums/ds_align.enum.dart';
import '../../../enums/ds_border_radius.enum.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../../utils/ds_utils.util.dart';
import '../../animations/ds_fading_circle_loading.widget.dart';
import '../../buttons/ds_button.widget.dart';
import '../../buttons/ds_play_button_rounded.widget.dart';
import '../../texts/ds_body_text.widget.dart';
import '../ds_message_bubble.widget.dart';
import 'ds_video_player.widget.dart';

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

  // Unique id to message bubble
  final String uniqueId;

  /// The video size
  final int mediaSize;

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
    this.appBarPhotoUri,
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
    required this.uniqueId,
    required this.mediaSize,
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
        uniqueId: widget.uniqueId,
        url: widget.url,
        mediaSize: widget.mediaSize);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final foregroundColor = widget.style.isLightBubbleBackground(widget.align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    final backgroundLoadingColor =
        widget.style.isLightBubbleBackground(widget.align)
            ? DSColors.neutralLightSnow
            : DSColors.neutralDarkCity;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => SizedBox(
              height: 240,
              width: 240,
              child: _controller.hasError.value
                  ? const Icon(
                      DSIcons.video_broken_outline,
                      size: 80.0,
                      color: DSColors.neutralDarkRooftop,
                    )
                  : _controller.isDownloading.value
                      ? Center(
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: foregroundColor),
                            child: DSFadingCircleLoading(
                              color: backgroundLoadingColor,
                              size: 45.0,
                            ),
                          ),
                        )
                      : _controller.thumbnail.isEmpty
                          ? Center(
                              child: SizedBox(
                                width: 122,
                                height: 40,
                                child: DSButton(
                                  leadingIcon: const Icon(
                                    DSIcons.download_outline,
                                    size: 20,
                                  ),
                                  backgroundColor: buttonBackgroundColor,
                                  foregroundColor: buttonForegroundColor,
                                  borderColor: buttonBorderColor,
                                  label: _controller.size,
                                  onPressed: () async =>
                                      await _controller.downloadVideo(),
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Center(
                                  child: Image.file(
                                    File(
                                      _controller.thumbnail.value,
                                    ),
                                    width: 240,
                                    height: 240,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Center(
                                  child: DSRoundedPlayButton(
                                    align: widget.align,
                                    onPressed: () async {
                                      SystemChrome.setSystemUIOverlayStyle(
                                        const SystemUiOverlayStyle(
                                            systemNavigationBarColor:
                                                Colors.black,
                                            systemNavigationBarDividerColor:
                                                Colors.black,
                                            systemNavigationBarIconBrightness:
                                                Brightness.light),
                                      );

                                      await showGeneralDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        transitionDuration:
                                            DSUtils.defaultAnimationDuration,
                                        transitionBuilder: (_, animation, __,
                                                child) =>
                                            _buildTransition(animation, child),
                                        pageBuilder: (context, _, __) =>
                                            DSVideoPlayer(
                                          appBarText: widget.appBarText,
                                          appBarPhotoUri: widget.appBarPhotoUri,
                                          url: widget.url,
                                          uniqueId: widget.uniqueId,
                                        ),
                                      ).then(
                                        (value) {
                                          SystemChrome.setSystemUIOverlayStyle(
                                            const SystemUiOverlayStyle(
                                                systemNavigationBarColor:
                                                    DSColors.neutralLightSnow,
                                                systemNavigationBarDividerColor:
                                                    DSColors.neutralLightSnow,
                                                systemNavigationBarIconBrightness:
                                                    Brightness.dark),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
            ),
          ),
          if (widget.text?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: DSBodyText(
                widget.text!,
                color: foregroundColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransition(Animation<double> animation, Widget? child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
