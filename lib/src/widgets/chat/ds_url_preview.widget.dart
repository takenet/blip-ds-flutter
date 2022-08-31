import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_url_preview.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

/// A Design System's clickable URL previewer that shows some metadata infos about the given [url].
class DSUrlPreview extends StatelessWidget {
  final Uri url;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<DSBorderRadius> borderRadius;
  final EdgeInsets bodyPadding;

  final _controller = DSUrlPreviewController();

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
  });

  @override
  Widget build(BuildContext context) {
    _controller.getUrlPreview(url);

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
                    borderRadius: borderRadius.getCircularBorderRadius(
                      maxRadius: 18.0,
                    ),
                    color: backgroundColor,
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
        color: foregroundColor,
      ),
    );
  }

  Widget _buildPreview() {
    return GestureDetector(
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
    );
  }

  Widget _buildImage({
    required String path,
  }) {
    return DSCachedNetworkImageView(
      url: path,
      height: 150.0,
      width: double.infinity,
    );
  }

  Widget _buildBody({
    String? title,
    String? description,
  }) {
    return Padding(
      padding: bodyPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title?.isNotEmpty ?? false)
            DSBodyText(
              text: title,
              color: foregroundColor,
              shouldLinkify: false,
            ),
          if (description?.isNotEmpty ?? false)
            DSCaptionSmallText(
              text: description,
              color: foregroundColor,
              maxLines: 3,
              shouldLinkify: false,
            ),
        ],
      ),
    );
  }
}
