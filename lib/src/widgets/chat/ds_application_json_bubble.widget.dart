import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_delivery_report_status.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_unsupported_content_message_bubble.widget.dart';

class DSApplicationJsonMessageBubble extends StatelessWidget {
  DSApplicationJsonMessageBubble({
    super.key,
    required this.align,
    required this.borderRadius,
    required this.content,
    this.status,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final Map<String, dynamic> content;
  final DSDeliveryReportStatus? status;
  final DSMessageBubbleStyle style;

  @override
  Widget build(BuildContext context) {
    if (content['type'] == 'template') {
      return Opacity(
        opacity: status == DSDeliveryReportStatus.failed ? .3 : 1,
        child: DSUnsupportedContentMessageBubble(
          align: align,
          borderRadius: borderRadius,
          style: style,
          overflow: TextOverflow.visible,
          text: content['template']['name'],
          leftWidget: Icon(
            DSIcons.megaphone_outline,
            color: style.isLightBubbleBackground(align)
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
            size: 20.0,
          ),
        ),
      );
    }

    return DSUnsupportedContentMessageBubble(
      align: align,
      borderRadius: borderRadius,
      style: style,
    );
  }
}
