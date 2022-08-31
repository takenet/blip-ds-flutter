import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/chat/ds_delivery_report_icon.widget.dart';
import 'package:flutter/material.dart';

/// A Design System widget used to display a date and a [DSDeliveryReportIcon] at a message.
class DSMessageBubbleDetail extends StatelessWidget {
  final String date;
  final DSAlign align;
  final DSDeliveryReportStatus deliveryStatus;

  /// Creates a new Design System's [DSMessageBubbleDetail]
  const DSMessageBubbleDetail({
    Key? key,
    required this.date,
    required this.align,
    required this.deliveryStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: align == DSAlign.right
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0),
          child: Row(
            children: [
              if (align == DSAlign.right) ...[
                DSDeliveryReportIcon(deliveryStatus: deliveryStatus),
                const SizedBox(
                  width: 6.0,
                ),
              ],
              DSCaptionSmallText(
                text: date,
                color: DSColors.neutralDarkCity,
              )
            ],
          ),
        ),
      ],
    );
  }
}