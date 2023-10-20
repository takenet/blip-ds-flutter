import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../utils/ds_bubble.util.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../buttons/ds_request_location_button.widget.dart';
import 'ds_text_message_bubble.widget.dart';

class DSRequestLocationBubble extends StatelessWidget {
  DSRequestLocationBubble({
    super.key,
    required this.label,
    required this.value,
    required this.align,
    this.replyId,
    this.type = DSMessageContentType.textPlain,
    this.borderRadius = const [DSBorderRadius.all],
    this.showRequestLocationButton = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final String? label;
  final String type;
  final String? value;
  final String? replyId;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final bool showRequestLocationButton;
  final DSMessageBubbleStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: DSBubbleUtils.addSpacer(
        align: align,
        child: Column(
          crossAxisAlignment: align == DSAlign.right
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (label != null && type == DSMessageContentType.textPlain)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 3.0,
                ),
                child: DSTextMessageBubble(
                  text: value!,
                  replyId: replyId,
                  align: align,
                  borderRadius: borderRadius,
                  style: style,
                ),
              ),
            if (showRequestLocationButton)
              DSRequestLocationButton(
                label: 'Send Location', // TODO: translate
              ),
          ],
        ),
      ),
    );
  }
}
