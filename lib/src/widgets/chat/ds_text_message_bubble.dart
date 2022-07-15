import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_text_message_bubble_controller.dart';
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
  late final DSTextMessageBubbleController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(DSTextMessageBubbleController());
  }

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
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        curve: Curves.linearToEaseOut,
        duration: const Duration(milliseconds: 300),
        clipBehavior: Clip.none,
        child: Obx(
          () => _buildText(),
        ),
      ),
    );
  }

  Widget _buildText() {
    final overflow =
        !controller.showFullText.value ? TextOverflow.ellipsis : null;

    final maxLines = !controller.showFullText.value ? 12 : null;

    final textSpan = TextSpan(
      text: widget.text,
      style: TextStyle(
        color: widget.align == DSAlign.right
            ? SystemColors.neutralLightSnow
            : SystemColors.neutralDarkCity,
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
              maxLines: maxLines,
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
        child: Text(
          // TODO: Need localized translate.
          'Mostrar mais',
          style: TextStyle(
            color: widget.align == DSAlign.right
                ? SystemColors.primaryLight
                : SystemColors.primaryNight,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
