import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import '../../controllers/chat/ds_image_message_bubble.controller.dart';
import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_document_select.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_utils.util.dart';
import '../texts/ds_caption_text.widget.dart';
import '../texts/ds_headline_small_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';
import '../utils/ds_user_avatar.widget.dart';
import '../animations/ds_spinner_loading.widget.dart';
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
                    replacement: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Center(
                        child: _buildLoading(),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (!_controller.error.value) {
                          _controller.appBarVisible.value = false;
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
                          placeholder: (_, __) => Center(
                            heightFactor: 5.0,
                            child: _buildLoading(),
                          ),
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
                  opacity: _controller.appBarVisible.value ? 1.0 : 0.0,
                  duration: DSUtils.defaultAnimationDuration,
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 20.0,
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          DSIcons.arrow_left_outline,
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
                onTap: () => _controller.showAppBar(),
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

  Widget _buildLoading() {
    return DSSpinnerLoading(
      color: widget.style.isLightBubbleBackground(widget.align)
          ? DSColors.primaryNight
          : DSColors.neutralLightSnow,
      size: 32.0,
      lineWidth: 4.0,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
