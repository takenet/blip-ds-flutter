import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/enums/ds_border_radius.enum.dart';
import 'package:blip_ds/src/controllers/chat/ds_url_preview.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DSUrlPreview extends StatelessWidget {
  final Uri url;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<DSBorderRadius> borderRadius;
  final EdgeInsets bodyPadding;

  final _controller = DSUrlPreviewController();

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
      () => _controller.urlPreview.value?.url == null &&
              !_controller.isLoading.value
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: DSAnimatedSize(
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
                      : _buildPreview(
                          url: _controller.urlPreview.value!.url,
                          imagePath: _controller.urlPreview.value?.image,
                          title: _controller.urlPreview.value?.title,
                          description:
                              _controller.urlPreview.value?.description,
                        ),
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

  Widget _buildPreview({
    required String url,
    String? imagePath,
    String? title,
    String? description,
  }) {
    return GestureDetector(
      onTap: () => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.inAppWebView,
      ).ignore(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath != null)
            _buildImage(
              path: imagePath,
            ),
          _buildBody(
            title: title,
            description: description,
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
