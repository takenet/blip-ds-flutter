import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../texts/ds_body_text.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSUnsupportedContentMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget? leftWidget;
  final String? text;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  DSUnsupportedContentMessageBubble({
    Key? key,
    required this.align,
    this.leftWidget,
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return DSMessageBubble(
      borderRadius: borderRadius,
      align: align,
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leftWidget ??
              Icon(
                DSIcons.false_icon,
                color: style.isLightBubbleBackground(align)
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
                size: 20.0,
              ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DSBodyText(
              text ?? 'Unsupported content',
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
