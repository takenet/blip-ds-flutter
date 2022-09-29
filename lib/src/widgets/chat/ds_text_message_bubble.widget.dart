import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/chat/ds_select_menu.widget.dart';
import 'package:blip_ds/src/widgets/chat/ds_show_more_text.widget.dart';
import 'package:flutter/material.dart';

class DSTextMessageBubble extends StatefulWidget {
  final String text;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final dynamic selectContent;
  final bool showSelect;
  final Function? onSelected;

  const DSTextMessageBubble({
    Key? key,
    required this.text,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    this.selectContent,
    this.showSelect = false,
    this.onSelected,
  }) : super(key: key);

  @override
  State<DSTextMessageBubble> createState() => _DSTextMessageBubbleState();
}

class _DSTextMessageBubbleState extends State<DSTextMessageBubble> {
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
      child: _buildText(),
    );
  }

  Widget _buildText() {
    final foregroundColor = widget.align == DSAlign.right
        ? DSColors.neutralLightSnow
        : DSColors.neutralDarkCity;

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
                backgroundColor: widget.align == DSAlign.right
                    ? DSColors.neutralDarkDesk
                    : DSColors.neutralLightBox,
                borderRadius: widget.borderRadius,
              ),
            Padding(
              padding: _defaultBodyPadding,
              child: DSShowMoreText(
                align: widget.align,
                text: widget.text,
                maxWidth: constraints.maxWidth,
              ),
            ),
            if (widget.showSelect)
              DSSelectMenu(
                align: widget.align,
                content: widget.selectContent,
                onSelected: widget.onSelected,
              ),
          ],
        );
      },
    );
  }
}
