import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_text_message_bubble.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DSTextMessageBubble extends StatefulWidget {
  final String text;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;

  const DSTextMessageBubble({
    Key? key,
    required this.text,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
  }) : super(key: key);

  @override
  State<DSTextMessageBubble> createState() => _DSTextMessageBubbleState();
}

class _DSTextMessageBubbleState extends State<DSTextMessageBubble> {
  final _controller = DSTextMessageBubbleController();

  final EdgeInsets _defaultBodyPadding = const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 16.0,
  );

  @override
  void didUpdateWidget(covariant DSTextMessageBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _controller.shouldShowFullText.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: widget.align,
      borderRadius: widget.borderRadius,
      padding: EdgeInsets.zero,
      child: Obx(
        () => _buildText(),
      ),
    );
  }

  Widget _buildText() {
    final overflow =
        !_controller.shouldShowFullText.value ? TextOverflow.ellipsis : null;

    final maxLines = !_controller.shouldShowFullText.value ? 12 : null;

    final foregroundColor = widget.align == DSAlign.right
        ? DSColors.neutralLightSnow
        : DSColors.neutralDarkCity;

    final textSpan = TextSpan(
      text: widget.text,
      style: DSBodyTextStyle(
        color: foregroundColor,
      ),
    );

    final textPainter = TextPainter(
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
      text: textSpan,
    );

    return LayoutBuilder(
      builder: (_, constraints) {
        textPainter.layout(maxWidth: constraints.maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSUrlPreview(
              url: DSLinkify.getFirstUrlFromText(widget.text),
              foregroundColor: foregroundColor,
              backgroundColor: widget.align == DSAlign.right
                  ? DSColors.neutralDarkDesk
                  : DSColors.neutralLightBox,
              borderRadius: widget.borderRadius,
            ),
            Padding(
              padding: _defaultBodyPadding,
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
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: _controller.showMoreOnTap,
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
