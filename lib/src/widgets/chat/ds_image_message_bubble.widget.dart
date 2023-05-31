import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../controllers/chat/ds_image_message_bubble.controller.dart';
import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_document_select.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/system_overlay/ds_system_overlay.style.dart';
import '../../utils/ds_utils.util.dart';
import '../animations/ds_spinner_loading.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';
import '../utils/ds_header.widget.dart';
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
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final String url;
  final List<DSBorderRadius> borderRadius;
  final String? title;
  final bool hasSpacer;
  final String? text;
  final String appBarText;
  final Uri? appBarPhotoUri;
  final DSMessageBubbleStyle style;
  final List<DSDocumentSelectOption> selectOptions;
  final bool showSelect;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;

  @override
  State<StatefulWidget> createState() => _DSImageMessageBubbleState();
}

class _DSImageMessageBubbleState extends State<DSImageMessageBubble>
    with AutomaticKeepAliveClientMixin {
  late final DSImageMessageBubbleController _controller;

  @override
  initState() {
    _controller = DSImageMessageBubbleController();

    super.initState();
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
      borderRadius: widget.borderRadius,
      padding: EdgeInsets.zero,
      hasSpacer: widget.hasSpacer,
      style: widget.style,
      child: FutureBuilder(
        future: _controller.getImageInfo(widget.url),
        builder: (buildContext, snapshot) {
          final isLoadingImage = !(snapshot.hasData || snapshot.hasError);

          final ImageInfo? data =
              snapshot.hasData ? snapshot.data as ImageInfo : null;

          final width =
              snapshot.hasData && data!.image.width > DSUtils.bubbleMinSize
                  ? data.image.width.toDouble()
                  : DSUtils.bubbleMinSize;

          return LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: !isLoadingImage,
                    replacement: _buildLoading(),
                    child: GestureDetector(
                      onTap: () {
                        if (!_controller.error.value) {
                          _controller.appBarVisible.value = true;

                          showGeneralDialog(
                            context: context,
                            barrierDismissible: false,
                            transitionDuration:
                                DSUtils.defaultAnimationDuration,
                            transitionBuilder: (_, animation, __, child) =>
                                _buildTransition(animation, child),
                            pageBuilder: (context, _, __) =>
                                _buildPage(context),
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
                          placeholder: (_, __) => _buildLoading(),
                          onError: _controller.setError,
                          align: widget.align,
                          style: widget.style,
                        ),
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
          );
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
    const overlayStyle = DSSystemOverlayStyle.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Obx(
        () => Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          appBar: DSHeader(
            showBorder: false,
            visible: _controller.appBarVisible.value,
            title: widget.appBarText,
            customerUri: widget.appBarPhotoUri,
            customerName: widget.appBarText,
            backgroundColor: Colors.black.withOpacity(0.7),
            onBackButtonPressed: Get.back,
            systemUiOverlayStyle: overlayStyle,
          ),
          body: GestureDetector(
            onTap: () => _controller.showAppBar(),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: PinchZoom(
                child: DSCachedNetworkImageView(
                  url: widget.url,
                  fit: BoxFit.contain,
                  align: widget.align,
                  style: widget.style,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Center(
            child: DSSpinnerLoading(
              color: widget.style.isLightBubbleBackground(widget.align)
                  ? DSColors.primaryNight
                  : DSColors.neutralLightSnow,
              size: 32.0,
              lineWidth: 4.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
