import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat/ds_image_message_bubble.controller.dart';
import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_document_select.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../texts/ds_caption_text.widget.dart';
import '../utils/ds_circular_progress.widget.dart';
import '../utils/ds_expanded_image.widget.dart';
import 'ds_document_select.widget.dart';
import 'ds_message_bubble.widget.dart';
import 'ds_show_more_text.widget.dart';

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
    this.hasSpacer = true,
    DSMessageBubbleStyle? style,
    this.selectOptions = const [],
    this.showSelect = false,
    this.onSelected,
    this.onOpenLink,
    this.replyContent,
    this.shouldAuthenticate = false,
    this.mediaType,
    this.imageMaxHeight,
    this.imageMinHeight,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final String url;
  final List<DSBorderRadius> borderRadius;
  final String? title;
  final bool hasSpacer;
  final String? text;
  final String appBarText;
  final Uri? appBarPhotoUri;
  final dynamic replyContent;
  final DSMessageBubbleStyle style;
  final List<DSDocumentSelectOption> selectOptions;
  final bool showSelect;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;
  final bool shouldAuthenticate;
  final String? mediaType;
  final double? imageMaxHeight;
  final double? imageMinHeight;

  @override
  State<StatefulWidget> createState() => _DSImageMessageBubbleState();
}

class _DSImageMessageBubbleState extends State<DSImageMessageBubble>
    with AutomaticKeepAliveClientMixin {
  late final DSImageMessageBubbleController _controller;

  @override
  initState() {
    super.initState();

    _controller = DSImageMessageBubbleController(
      widget.url,
      mediaType: widget.mediaType,
      shouldAuthenticate: widget.shouldAuthenticate,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final foregroundColor = widget.style.isLightBubbleBackground(widget.align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return DSMessageBubble(
      defaultMaxSize: 360.0,
      shouldUseDefaultSize: true,
      align: widget.align,
      replyContent: widget.replyContent,
      borderRadius: widget.borderRadius,
      padding: EdgeInsets.zero,
      hasSpacer: widget.hasSpacer,
      style: widget.style,
      child: Padding(
        padding: widget.replyContent == null
            ? EdgeInsets.zero
            : const EdgeInsets.only(top: 8.0),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => _controller.localPath.value != null
                      ? DSExpandedImage(
                          appBarText: widget.appBarText,
                          appBarPhotoUri: widget.appBarPhotoUri,
                          url: _controller.localPath.value!,
                          maxHeight: widget.imageMaxHeight != null
                              ? widget.imageMaxHeight!
                              : widget.showSelect
                                  ? 200.0
                                  : double.infinity,
                          minHeight: widget.imageMinHeight != null
                              ? widget.imageMinHeight!
                              : widget.showSelect
                                  ? 200.0
                                  : 0.0,
                          align: widget.align,
                          style: widget.style,
                          isLoading: false,
                          shouldAuthenticate: widget.shouldAuthenticate,
                        )
                      : DSCircularProgress(
                          currentProgress: _controller.downloadProgress,
                          maximumProgress: _controller.maximumProgress,
                          foregroundColor: foregroundColor,
                        ),
                ),
                if ((widget.title?.isNotEmpty ?? false) ||
                    (widget.text?.isNotEmpty ?? false))
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.title?.isNotEmpty ?? false)
                            DSCaptionText(
                              widget.title!,
                              color: foregroundColor,
                              isSelectable: true,
                            ),
                          if ((widget.text?.isNotEmpty ?? false) &&
                              (widget.title?.isNotEmpty ?? false))
                            const SizedBox(
                              height: 6.0,
                            ),
                          if (widget.text?.isNotEmpty ?? false)
                            DSShowMoreText(
                              text: widget.text!,
                              maxWidth: constraints.maxWidth,
                              align: widget.align,
                              style: widget.style,
                            )
                        ],
                      ),
                    ),
                  ),
                if (widget.showSelect)
                  DSDocumentSelect(
                    align: widget.align,
                    options: widget.selectOptions,
                    onSelected: widget.onSelected,
                    onOpenLink: widget.onOpenLink,
                    style: widget.style,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
