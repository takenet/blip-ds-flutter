import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_text_message_bubble.controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkify/linkify.dart';
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

    final elements = linkify(
      widget.text,
      linkifiers: const [
        UrlLinkifier(),
      ],
      options: const LinkifyOptions(
        looseUrl: true,
        defaultToHttps: true,
      ),
    );

    final List<TextSpan> fullText = [];

    for (var element in elements) {
      if (element is TextElement) {
        fullText.add(
          TextSpan(
            text: element.text,
            style: DSBodyTextStyle(
              color: widget.align == DSAlign.right
                  ? DSColors.neutralLightSnow
                  : DSColors.neutralDarkCity,
              overflow: overflow,
            ),
          ),
        );
      } else {
        final String url = (element as UrlElement).url;

        fullText.add(
          TextSpan(
            text: url,
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrlString(
                    url,
                    mode: LaunchMode.inAppWebView,
                  ),
            style: DSBodyTextStyle(
              color: widget.align == DSAlign.right
                  ? DSColors.primaryLight
                  : DSColors.primaryNight,
              decoration: TextDecoration.underline,
              overflow: overflow,
            ),
          ),
        );
      }
    }

    final textSpan = TextSpan(
      children: fullText,
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
            RichText(
              text: textSpan,
              maxLines: textPainter.maxLines,
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
