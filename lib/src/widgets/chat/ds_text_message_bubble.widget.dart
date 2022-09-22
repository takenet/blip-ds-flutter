import 'package:blip_ds/src/controllers/chat/ds_text_message_bubble.controller.dart';
import 'package:blip_ds/src/widgets/chat/ds_select_menu.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../utils/ds_linkify.util.dart';
import '../texts/ds_body_text.widget.dart';
import 'ds_message_bubble.widget.dart';
import 'ds_url_preview.widget.dart';

class DSTextMessageBubble extends StatefulWidget {
  final String text;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final dynamic selectContent;
  final bool showSelect;
  final Function? onSelected;
  final DSMessageBubbleStyle style;

  DSTextMessageBubble({
    Key? key,
    required this.text,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    this.selectContent,
    this.showSelect = false,
    this.onSelected,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

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
      style: widget.style,
      child: Obx(
        () => _buildText(),
      ),
    );
  }

  Widget _buildText() {
    final overflow =
        !_controller.shouldShowFullText.value ? TextOverflow.ellipsis : null;

    final maxLines = !_controller.shouldShowFullText.value ? 12 : null;

    final foregroundColor = widget.style.isLightBubbleBackground(widget.align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    final url = DSLinkify.getFirstUrlFromText(widget.text);

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
        final defaultBubbleColors =
            widget.style.isDefaultBubbleBackground(widget.align);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (url.toString().isNotEmpty)
              DSUrlPreview(
                url: url,
                foregroundColor: foregroundColor,
                backgroundColor:
                    widget.style.isLightBubbleBackground(widget.align)
                        ? DSColors.neutralLightBox
                        : DSColors.neutralDarkDesk,
                borderRadius: widget.borderRadius,
              ),
            Padding(
              padding: _defaultBodyPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DSBodyText.rich(
                    textSpan,
                    linkColor:
                        widget.style.isLightBubbleBackground(widget.align)
                            ? defaultBubbleColors
                                ? DSColors.primaryNight
                                : DSColors.neutralDarkCity
                            : defaultBubbleColors
                                ? DSColors.primaryLight
                                : DSColors.neutralLightSnow,
                    overflow: overflow,
                    maxLines: textPainter.maxLines,
                  ),
                  if (textPainter.didExceedMaxLines) _buildShowMore(),
                ],
              ),
            ),
            if (widget.showSelect)
              DSSelectMenu(
                align: widget.align,
                content: widget.selectContent,
                onSelected: widget.onSelected,
                style: widget.style,
              ),
          ],
        );
      },
    );
  }

  Widget _buildShowMore() {
    final defaultBubbleColors =
        widget.style.isDefaultBubbleBackground(widget.align);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: _controller.showMoreOnTap,
        child: DSBodyText(
          // TODO: Need localized translate.
          'Mostrar mais',
          color: widget.style.isLightBubbleBackground(widget.align)
              ? defaultBubbleColors
                  ? DSColors.primaryNight
                  : DSColors.neutralDarkCity
              : defaultBubbleColors
                  ? DSColors.primaryLight
                  : DSColors.neutralLightSnow,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
