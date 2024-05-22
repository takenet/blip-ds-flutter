import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_delivery_report_status.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../texts/ds_caption_small_text.widget.dart';
import 'ds_delivery_report_icon.widget.dart';

/// A Design System widget used to display a date and a [DSDeliveryReportIcon] at a message.
class DSMessageBubbleDetail extends StatelessWidget {
  final String? date;
  final Widget? detailWidget;
  final DSAlign align;
  final DSDeliveryReportStatus deliveryStatus;
  final DSMessageBubbleStyle style;
  final bool showMessageStatus;

  /// Creates a new Design System's [DSMessageBubbleDetail]
  const DSMessageBubbleDetail({
    super.key,
    required this.align,
    required this.deliveryStatus,
    required this.style,
    this.showMessageStatus = true,
    this.date,
    this.detailWidget,
  })  : assert((date != null || detailWidget != null));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: align == DSAlign.right
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showMessageStatus && align == DSAlign.right) ...[
                  DSDeliveryReportIcon(deliveryStatus: deliveryStatus),
                  const SizedBox(
                    width: 6.0,
                  ),
                ],
                _getDetailWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getDetailWidget() {
    if (detailWidget != null) {
      return Expanded(child: detailWidget!);
    }
    return DSCaptionSmallText(
      date,
      color: style.isPageBackgroundLight
          ? DSColors.neutralDarkCity
          : DSColors.neutralLightSnow,
    );
  }
}
