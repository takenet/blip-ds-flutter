import 'package:blip_ds/src/controllers/chat/ds_image_message_bubble.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../texts/ds_headline_small_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';
import '../utils/ds_user_avatar.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSImageMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String url;
  final List<DSBorderRadius> borderRadius;
  final String? imageTitle;
  final String? imageText;
  final String appBarText;
  final Uri? appBarPhotoUri;
  final DSMessageBubbleStyle style;

  final DSImageMessageBubbleController _controller;

  DSImageMessageBubble({
    super.key,
    required this.align,
    required this.url,
    this.imageTitle,
    required this.appBarText,
    this.appBarPhotoUri,
    this.borderRadius = const [DSBorderRadius.all],
    this.imageText,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        _controller = DSImageMessageBubbleController();

  Widget _buildTransition(Animation<double> animation, Widget? child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Obx(
          () {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: AnimatedOpacity(
                  opacity: _controller.appBarVisible.value ? 1.0 : 0.0,
                  duration: DSUtils.defaultAnimationDuration,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: DSColors.neutralLightSnow,
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: DSUserAvatar(
                              text: appBarText,
                              uri: appBarPhotoUri,
                            ),
                            title: DSHeadlineSmallText(
                              appBarText,
                              color: DSColors.neutralLightSnow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: GestureDetector(
                onTap: () => _controller.showAppBar(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black,
                  child: PinchZoom(
                    resetDuration: const Duration(milliseconds: 100),
                    child: DSCachedNetworkImageView(
                      url: url,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = align == DSAlign.right
        ? style.isSentBackgroundLight
            ? DSColors.neutralDarkCity
            : DSColors.neutralLightSnow
        : style.isReceivedBackgroundLight
            ? DSColors.neutralDarkCity
            : DSColors.neutralLightSnow;

    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      style: style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (!_controller.error.value) {
                _controller.appBarVisible.value = false;
                showGeneralDialog(
                  context: context,
                  barrierDismissible: false,
                  transitionDuration: DSUtils.defaultAnimationDuration,
                  transitionBuilder: (_, animation, __, child) => _buildTransition(animation, child),
                  pageBuilder: (context, _, __) => _buildPage(context),
                );
              }
            },
            child: DSCachedNetworkImageView(
              width: 240.0,
              height: 240.0,
              url: url,
              placeholder: (_, __) => const Padding(
                padding: EdgeInsets.all(80.0),
                child: CircularProgressIndicator(),
              ),
              onError: _controller.setError,
            ),
          ),
          if ((imageTitle?.isNotEmpty ?? false) || (imageText?.isNotEmpty ?? false))
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageTitle?.isNotEmpty ?? false)
                    DSCaptionText(
                      imageTitle,
                      color: color,
                    ),
                  if ((imageText?.isNotEmpty ?? false) && (imageTitle?.isNotEmpty ?? false)) ...[
                    const SizedBox(
                      height: 6.0,
                    ),
                    if (imageText?.isNotEmpty ?? false)
                      DSBodyText(
                        imageText!,
                        color: color,
                      ),
                  ]
                ],
              ),
            ),
        ],
      ),
    );
  }
}
