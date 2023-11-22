import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_delivery_report_status.enum.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/interactive_message/ds_interactive_message.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_interactive_button_message_bubble.widget.dart';
import 'ds_interactive_list_message_bubble.widget.dart';
import 'ds_unsupported_content_message_bubble.widget.dart';

class DSApplicationJsonMessageBubble extends StatelessWidget {
  DSApplicationJsonMessageBubble({
    super.key,
    required this.align,
    required this.content,
    this.borderRadius = const [DSBorderRadius.all],
    this.status,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        interactive = content['interactive'] ?? {},
        template = content['template'] ?? {};

  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSDeliveryReportStatus? status;
  final DSMessageBubbleStyle style;
  final DSMessageBubbleAvatarConfig avatarConfig;

  final Map<String, dynamic> content;
  final Map<String, dynamic> interactive;
  final Map<String, dynamic> template;

  @override
  Widget build(BuildContext context) => switch (content['type']) {
        'template' => _buildTemplate(),
        'interactive' => _buildInteractive(),
        _ => _buildUnsupportedContent(),
      };

  Widget _buildTemplate() => Opacity(
        opacity: status == DSDeliveryReportStatus.failed ? .3 : 1,
        child: DSUnsupportedContentMessageBubble(
          align: align,
          borderRadius: borderRadius,
          style: style,
          overflow: TextOverflow.visible,
          text: template['name'],
          leftWidget: Icon(
            DSIcons.megaphone_outline,
            color: style.isLightBubbleBackground(align)
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
            size: 20.0,
          ),
        ),
      );

  Widget _buildInteractive() {
    final content = DSInteractiveMessage.fromJson(interactive);

    return switch (interactive['type']) {
      'list' => DSInteractiveListMessageBubble(
          content: content,
          align: align,
          borderRadius: borderRadius,
          style: style,
        ),
      'button' => DSInteractiveButtonMessageBubble(
          content: content,
          align: align,
          borderRadius: borderRadius,
          style: style,
          avatarConfig: avatarConfig,
        ),
      _ => _buildUnsupportedContent(),
    };
  }

  Widget _buildUnsupportedContent() => DSUnsupportedContentMessageBubble(
        align: align,
        borderRadius: borderRadius,
        style: style,
      );
}
