import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/chat/ds_url_preview.controller.dart';
import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../animations/ds_animated_size.widget.dart';
import '../animations/ds_ring_loading.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_small_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';

/// A Design System's clickable URL previewer that shows some metadata infos about the given [url].
class DSUrlPreview extends StatefulWidget {
  final Uri url;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<DSBorderRadius> borderRadius;
  final EdgeInsets bodyPadding;
  final DSAlign align;
  final DSMessageBubbleStyle style;

  /// Creates a Design System's clickable URL previewer that shows some metadata infos about the given [url].
  DSUrlPreview({
    required this.url,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
    this.borderRadius = const [DSBorderRadius.all],
    this.bodyPadding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
    required this.align,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  State<StatefulWidget> createState() => _DSUrlPreviewState();
}

class _DSUrlPreviewState extends State<DSUrlPreview>
    with AutomaticKeepAliveClientMixin {
  late final DSUrlPreviewController _controller;

  @override
  initState() {
    _controller = DSUrlPreviewController(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Obx(
      () => DSAnimatedSize(
        child: _controller.urlPreview.value?.url == null &&
                !_controller.isLoading.value
            ? const SizedBox(
                width: double.infinity,
              )
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius.getCircularBorderRadius(
                      maxRadius: 18.0,
                    ),
                    color: widget.backgroundColor,
                  ),
                  child: _controller.isLoading.value
                      ? _buildLoading()
                      : _buildPreview(),
                ),
              ),
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: 56.0,
      child: DSRingLoading(
        color: widget.foregroundColor,
      ),
    );
  }

  Widget _buildPreview() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => launchUrl(
          Uri.parse(_controller.urlPreview.value!.url),
          mode: LaunchMode.inAppWebView,
        ).ignore(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.urlPreview.value?.image != null)
              _buildImage(
                path: _controller.urlPreview.value!.image!,
              ),
            _buildBody(
              title: _controller.urlPreview.value?.title,
              description: _controller.urlPreview.value?.description,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage({
    required String path,
  }) {
    return DSCachedNetworkImageView(
      url: path,
      height: 150.0,
      width: double.infinity,
      align: widget.align,
      style: widget.style,
    );
  }

  Widget _buildBody({
    String? title,
    String? description,
  }) {
    return Padding(
      padding: widget.bodyPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title?.isNotEmpty ?? false)
            DSBodyText(
              title,
              color: widget.foregroundColor,
              shouldLinkify: false,
            ),
          if (description?.isNotEmpty ?? false)
            DSCaptionSmallText(
              description,
              color: widget.foregroundColor,
              maxLines: 3,
              shouldLinkify: false,
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
