import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../enums/ds_border_radius.enum.dart';
import '../../../extensions/ds_localization.extension.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../texts/ds_body_text.widget.dart';
import '../ds_message_bubble.widget.dart';
import '../ds_unsupported_content_message_bubble.widget.dart';

class DSCallsCustomerPermissionsBubble extends StatelessWidget {
  final Map content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  DSCallsCustomerPermissionsBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    final color = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return content.containsKey('response')
        ? DSMessageBubble(
            align: align,
            borderRadius: borderRadius,
            style: style,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  DSIcons.voip_calling_outline,
                  color: color,
                  size: 20.0,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DSBodyText(
                      _getLabel(),
                      color: color,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ],
            ),
          )
        : DSUnsupportedContentMessageBubble(
            align: align,
            borderRadius: borderRadius,
            style: style,
          );
  }

  String _getLabel() {
    return content['response'].toString().toLowerCase() == 'accept'
        ? 'calls.permissions-accept'.translate()
        : 'calls.permissions-reject'.translate();
  }
}
