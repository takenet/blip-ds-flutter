import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_message/ds_interactive_message.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../texts/ds_headline_small_text.widget.dart';
import '../utils/ds_divider.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSInteractiveVoiceCallMessageBubble extends StatefulWidget {
  final DSInteractiveMessage content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  DSInteractiveVoiceCallMessageBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  State<DSInteractiveVoiceCallMessageBubble> createState() =>
      _DSInteractiveVoiceCallMessageBubbleState();
}

class _DSInteractiveVoiceCallMessageBubbleState
    extends State<DSInteractiveVoiceCallMessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSMessageBubble(
          align: widget.align,
          style: widget.style,
          borderRadius: widget.borderRadius,
          child: Column(
            children: [
              DSHeadlineSmallText(
                widget.content.body?.text,
                overflow: TextOverflow.visible,
                color: DSColors.neutralLightSnow,
              ),
              const SizedBox(
                height: 10,
              ),
              const DSDivider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(DSIcons.plus_outline),
                  const SizedBox(
                    width: 10,
                  ),
                  DSHeadlineSmallText(
                    widget.content.action?.parameters?['display_text'],
                    overflow: TextOverflow.visible,
                    color: DSColors.neutralLightSnow,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
