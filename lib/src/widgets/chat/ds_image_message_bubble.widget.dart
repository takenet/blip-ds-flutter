import 'package:blip_ds/src/controllers/chat/ds_image_message_bubble.controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_utils.util.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../texts/ds_headline_small_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';
import '../utils/ds_user_avatar.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSImageMessageBubble extends StatefulWidget {
  DSImageMessageBubble({
    super.key,
    required this.align,
    required this.url,
    required this.appBarText,
    this.appBarPhotoUri,
    this.borderRadius = const [DSBorderRadius.all],
    this.text,
    this.title,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        _controller = DSImageMessageBubbleController();

  final DSAlign align;
  final String url;
  final List<DSBorderRadius> borderRadius;
  final String? title;
  final String? text;
  final String appBarText;
  final Uri? appBarPhotoUri;
  final DSMessageBubbleStyle style;

  final DSImageMessageBubbleController _controller;

  @override
  State<StatefulWidget> createState() => _DSImageMessageBubbleState();
}

class _DSImageMessageBubbleState extends State<DSImageMessageBubble>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final color = widget.style.isLightBubbleBackground(widget.align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return DSMessageBubble(
      defaultMaxSize: 360.0,
      shouldUseDefaultSize: true,
      align: widget.align,
      borderRadius: widget.borderRadius,
      padding: EdgeInsets.zero,
      style: widget.style,
      child: FutureBuilder(
        future: widget._controller.getImageInfo(widget.url),
        builder: (buildContext, snapshot) {
          if (snapshot.hasData || snapshot.hasError) {
            final ImageInfo? data =
                snapshot.hasError ? null : snapshot.data as ImageInfo;

            final width = snapshot.hasError
                ? 240.0
                : data!.image.width <= DSUtils.bubbleMinSize
                    ? DSUtils.bubbleMinSize
                    : data.image.width.toDouble();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!widget._controller.error.value) {
                      widget._controller.appBarVisible.value = false;
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: false,
                        transitionDuration: DSUtils.defaultAnimationDuration,
                        transitionBuilder: (_, animation, __, child) =>
                            _buildTransition(animation, child),
                        pageBuilder: (context, _, __) => _buildPage(context),
                      );
                    }
                  },
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: DSUtils.bubbleMaxSize,
                    ),
                    child: DSCachedNetworkImageView(
                      fit: BoxFit.cover,
                      width: width,
                      url: widget.url,
                      placeholder: (_, __) => const Padding(
                        padding: EdgeInsets.all(80.0),
                        child: CircularProgressIndicator(),
                      ),
                      onError: widget._controller.setError,
                      align: widget.align,
                      style: widget.style,
                    ),
                  ),
                ),
                if ((widget.title?.isNotEmpty ?? false) ||
                    (widget.text?.isNotEmpty ?? false))
                  SizedBox(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.title?.isNotEmpty ?? false)
                            DSCaptionText(
                              widget.title!,
                              color: color,
                            ),
                          if ((widget.text?.isNotEmpty ?? false) &&
                              (widget.title?.isNotEmpty ?? false)) ...[
                            const SizedBox(
                              height: 6.0,
                            ),
                            if (widget.text?.isNotEmpty ?? false)
                              DSBodyText(
                                widget.text!,
                                color: color,
                              ),
                          ]
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }
          return const SizedBox();
        },
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

  Widget _buildPage(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Obx(
          () {
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: AnimatedOpacity(
                  opacity: widget._controller.appBarVisible.value ? 1.0 : 0.0,
                  duration: DSUtils.defaultAnimationDuration,
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 20.0,
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          DSIcons.arrow_left,
                          color: DSColors.neutralLightSnow,
                          size: 32.0,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: DSUserAvatar(
                            text: widget.appBarText,
                            uri: widget.appBarPhotoUri,
                          ),
                          title: DSHeadlineSmallText(
                            widget.appBarText,
                            color: DSColors.neutralLightSnow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: GestureDetector(
                onTap: () => widget._controller.showAppBar(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black,
                  child: PinchZoom(
                    resetDuration: const Duration(milliseconds: 100),
                    child: DSCachedNetworkImageView(
                      url: widget.url,
                      fit: BoxFit.contain,
                      align: widget.align,
                      style: widget.style,
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
  bool get wantKeepAlive => true;
}
