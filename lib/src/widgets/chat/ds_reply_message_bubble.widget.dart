import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_linkify.util.dart';
import 'ds_message_bubble.widget.dart';
import 'ds_show_more_text.widget.dart';
import 'ds_url_preview.widget.dart';

class DSReplyMessageBubble extends StatefulWidget {
  final String text;
  final DSAlign align;
  final bool hasSpacer;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  DSReplyMessageBubble({
    Key? key,
    required this.text,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    this.hasSpacer = true,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  @override
  State<DSReplyMessageBubble> createState() => _DSTextMessageBubbleState();
}

class _DSTextMessageBubbleState extends State<DSReplyMessageBubble> {
  late final bool _isLightBubbleBackground;

  @override
  void initState() {
    super.initState();

    _isLightBubbleBackground =
        widget.style.isLightBubbleBackground(widget.align);
  }

  final EdgeInsets _defaultBodyPadding = const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: widget.align,
      borderRadius: widget.borderRadius,
      padding: EdgeInsets.zero,
      style: widget.style,
      hasSpacer: widget.hasSpacer,
      child: _buildText(),
    );
  }

  Widget _buildText() {
    final foregroundColor = widget.style.isLightBubbleBackground(widget.align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    final url = DSLinkify.getFirstUrlFromText(widget.text);

    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (url.toString().isNotEmpty)
              DSUrlPreview(
                url: url,
                foregroundColor: foregroundColor,
                backgroundColor: _isLightBubbleBackground
                    ? DSColors.neutralLightBox
                    : DSColors.neutralDarkDesk,
                borderRadius: widget.borderRadius,
                align: widget.align,
                style: widget.style,
              ),
            Padding(
              padding: _defaultBodyPadding,
              child: DSShowMoreText(
                align: widget.align,
                style: widget.style,
                text: widget.text,
                maxWidth: constraints.maxWidth,
              ),
            ),
          ],
        );
      },
    );
  }
}
