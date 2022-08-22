import 'package:any_link_preview/any_link_preview.dart';
import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_text_message_bubble.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DSTextMessageBubble extends StatefulWidget {
  final String text;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final bool groupWithPreviousMessage;

  const DSTextMessageBubble({
    Key? key,
    required this.text,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    this.groupWithPreviousMessage = false,
  }) : super(key: key);

  @override
  State<DSTextMessageBubble> createState() => _DSTextMessageBubbleState();
}

class _DSTextMessageBubbleState extends State<DSTextMessageBubble> {
  final DSTextMessageBubbleController controller =
      DSTextMessageBubbleController();

  @override
  void didUpdateWidget(covariant DSTextMessageBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      controller.showFullText.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: widget.align,
      borderRadius: widget.borderRadius,
      padding: EdgeInsets.zero,
      groupWithPreviousMessage: widget.groupWithPreviousMessage,
      child: Obx(
        () => _buildText(),
      ),
    );
  }

  Widget _buildText() {
    final overflow =
        !controller.showFullText.value ? TextOverflow.ellipsis : null;

    final maxLines = !controller.showFullText.value ? 12 : null;

    final textColor = widget.align == DSAlign.right
        ? DSColors.neutralLightSnow
        : DSColors.neutralDarkCity;

    final textSpan = TextSpan(
      text: widget.text,
      style: DSBodyTextStyle(
        color: textColor,
      ),
    );

    final textPainter = TextPainter(
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
      text: textSpan,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        textPainter.layout(maxWidth: constraints.maxWidth);

        final String urlPreview = DSLinkify.getFirstUrlFromText(widget.text);

        final padding = urlPreview.isNotEmpty
            ? const EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 8.0)
            : const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (urlPreview.isNotEmpty)
              AnyLinkPreview(
                link: urlPreview,
                urlLaunchMode: LaunchMode.inAppWebView,
                boxShadow: const [],
                backgroundColor: Colors.transparent,
                titleStyle: DSBodyTextStyle(
                  color: textColor,
                ),
                bodyStyle: DSCaptionSmallTextStyle(
                  color: textColor,
                ),
                bodyMaxLines: 3,
              ),
            Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DSBodyText.rich(
                    textSpan: textSpan,
                    linkColor: widget.align == DSAlign.right
                        ? DSColors.primaryLight
                        : DSColors.primaryNight,
                    overflow: overflow,
                    maxLines: textPainter.maxLines,
                  ),
                  if (textPainter.didExceedMaxLines) _buildShowMore(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShowMore() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: controller.showMoreOnTap,
        child: DSBodyText(
          // TODO: Need localized translate.
          text: 'Mostrar mais',
          color: widget.align == DSAlign.right
              ? DSColors.primaryLight
              : DSColors.primaryNight,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
