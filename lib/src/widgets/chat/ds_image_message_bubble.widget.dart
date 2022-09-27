import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_image_message_bubble.controller.dart';
import 'package:blip_ds/src/models/ds_document_select.model.dart';
import 'package:blip_ds/src/widgets/chat/typing/ds_document_select.widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class DSImageMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String url;
  final List<DSBorderRadius> borderRadius;
  final String? title;
  final String? text;
  final String appBarText;
  final List<DSDocumentSelectOption> selectOptions;
  final bool showSelect;
  final Function? onSelected;
  final void Function(Map<String, dynamic> payload)? onOpenLink;

  final DSImageMessageBubbleController _controller;

  DSImageMessageBubble({
    super.key,
    required this.align,
    required this.url,
    required this.appBarText,
    this.borderRadius = const [DSBorderRadius.all],
    this.text,
    this.title,
    this.selectOptions = const [],
    this.showSelect = false,
    this.onSelected,
    this.onOpenLink,
  }) : _controller = DSImageMessageBubbleController();

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      defaultMaxSize: 360.0,
      shouldUseDefaultSize: true,
      align: align,
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      child: FutureBuilder(
        future: _controller.getImageInfo(url),
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
                    if (!_controller.error.value) {
                      _controller.appBarVisible.value = false;

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
                      url: url,
                      placeholder: (_, __) => const Padding(
                        padding: EdgeInsets.all(80.0),
                        child: CircularProgressIndicator(),
                      ),
                      onError: _controller.setError,
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DSCaptionText(
                          text: title,
                          color: align == DSAlign.right
                              ? DSColors.neutralLightSnow
                              : DSColors.neutralDarkCity,
                        ),
                        if (text != null) ...[
                          const SizedBox(
                            height: 6.0,
                          ),
                          DSBodyText(
                            overflow: TextOverflow.clip,
                            text: text!,
                            color: align == DSAlign.right
                                ? DSColors.neutralLightSnow
                                : DSColors.neutralDarkCity,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (showSelect)
                  DSDocumentSelect(
                    align: align,
                    options: selectOptions,
                    onSelected: onSelected,
                    onOpenLink: onOpenLink,
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
                            ),
                            title: DSHeadlineSmallText(
                              text: appBarText,
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
}
