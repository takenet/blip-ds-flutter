import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_linkify.util.dart';

import 'ds_message_bubble.widget.dart';
import 'ds_select_menu.widget.dart';
import 'ds_show_more_text.widget.dart';
import 'ds_url_preview.widget.dart';

class DSTextMessageBubble extends StatefulWidget {
  final String text;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final dynamic selectContent;
  final bool showSelect;
  final void Function(String, Map<String, dynamic>)? onSelected;
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
  late final bool _isDefaultBubbleColors;
  late final bool _isLightBubbleBackground;

  @override
  void initState() {
    super.initState();

    _isDefaultBubbleColors =
        widget.style.isDefaultBubbleBackground(widget.align);
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
}
