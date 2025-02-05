import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_message/ds_interactive_message.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../texts/ds_body_text.widget.dart';
import '../utils/ds_divider.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSInteractiveVoiceCallMessageBubble extends StatelessWidget {
  final DSInteractiveMessage content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  late final bool _isLightBubbleBackground;
  late final Color _foregroundColor;

  DSInteractiveVoiceCallMessageBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle() {
    _initProperties();
  }

  void _initProperties() {
    _isLightBubbleBackground = style.isLightBubbleBackground(align);

    _foregroundColor = _isLightBubbleBackground
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      style: style,
      borderRadius: borderRadius,
      child: Column(
        children: [
          DSBodyText(
            content.body?.text,
            overflow: TextOverflow.visible,
            color: _foregroundColor,
          ),
          content.action?.name == 'voice_call'
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: DSDivider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            DSIcons.voip_outline,
                            color: _foregroundColor,
                          ),
                          content.action?.parameters?.displayText != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                  ),
                                  child: DSBodyText(
                                    content.action?.parameters?.displayText,
                                    overflow: TextOverflow.visible,
                                    color: _foregroundColor,
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
