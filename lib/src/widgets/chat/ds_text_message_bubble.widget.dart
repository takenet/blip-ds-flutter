import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_text_message_bubble.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DSTextMessageBubble extends StatefulWidget {
  final String text;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final bool groupWithPreviousMessage;
  final bool showMessageDetail;
  final DSDeliveryReportStatus deliveryStatus;
  final String date;

  const DSTextMessageBubble({
    Key? key,
    required this.text,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    this.groupWithPreviousMessage = false,
    this.showMessageDetail = true,
    this.deliveryStatus = DSDeliveryReportStatus.accepted,
    this.date = '',
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
      groupWithPreviousMessage: widget.groupWithPreviousMessage,
      showMessageDetail: widget.showMessageDetail,
      deliveryStatus: widget.deliveryStatus!,
      date: widget.date!,
      child: Obx(
        () => _buildText(),
      ),
    );
  }

  Widget _buildText() {
    final overflow =
        !controller.showFullText.value ? TextOverflow.ellipsis : null;
    final maxLines = !controller.showFullText.value ? 12 : null;

    final textSpan = TextSpan(
      text: widget.text,
      style: DSBodyTextStyle(
        color: widget.align == DSAlign.right
            ? DSColors.neutralLightSnow
            : DSColors.neutralDarkCity,
        overflow: overflow,
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              textSpan,
              maxLines: textPainter.maxLines,
              style: textSpan.style,
            ),
            if (textPainter.didExceedMaxLines) _buildShowMore(),
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
