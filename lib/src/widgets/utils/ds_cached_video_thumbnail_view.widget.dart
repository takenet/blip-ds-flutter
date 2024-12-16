import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat/ds_video_message_bubble.controller.dart';
import '../../enums/ds_align.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../services/ds_auth.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';

class DSCachedVideoThumbnailView extends StatefulWidget {
  final int mediaSize;
  final String url;
  final String type;
  final DSAlign align;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final void Function()? onError;
  final DSMessageBubbleStyle style;
  final bool shouldAuthenticate;

  final Widget Function(
    BuildContext context,
    String url,
  ) placeholder;

  final Widget Function(
    BuildContext context,
    String url,
    dynamic error,
  )? errorWidget;

  DSCachedVideoThumbnailView({
    super.key,
    required this.url,
    required this.align,
    required this.mediaSize,
    required this.type,
    required this.placeholder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.onError,
    this.shouldAuthenticate = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  State<DSCachedVideoThumbnailView> createState() =>
      _DSCachedVideoThumbnailViewState();
}

class _DSCachedVideoThumbnailViewState
    extends State<DSCachedVideoThumbnailView> {
  late final _controller = DSVideoMessageBubbleController(
    url: widget.url,
    mediaSize: widget.mediaSize,
    httpHeaders: widget.shouldAuthenticate ? DSAuthService.httpHeaders : null,
    type: widget.type,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Obx(
        () => widget.url.isEmpty
            ? _buildError(context)
            : _controller.isLoadingThumbnail.value
                ? widget.placeholder(context, widget.url)
                : _controller.thumbnail.isEmpty
                    ? Center(
                        child: Icon(
                          DSIcons.video_broken_outline,
                          color:
                              widget.style.isLightBubbleBackground(widget.align)
                                  ? DSColors.neutralMediumElephant
                                  : DSColors.neutralMediumCloud,
                        ),
                      )
                    : Image.file(
                        File(
                          _controller.thumbnail.value,
                        ),
                        width: widget.width,
                        height: widget.height,
                        fit: BoxFit.cover,
                      ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    widget.onError?.call();

    return widget.errorWidget != null
        ? widget.errorWidget!(context, widget.url, null)
        : _defaultErrorWidget();
  }

  Widget _defaultErrorWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Icon(
        DSIcons.file_image_broken_outline,
        color: widget.style.isLightBubbleBackground(widget.align)
            ? DSColors.neutralMediumElephant
            : DSColors.neutralMediumCloud,
        size: 75,
      ),
    );
  }
}
