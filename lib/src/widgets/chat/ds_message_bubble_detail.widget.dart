import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

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
    Key? key,
    required this.align,
    required this.deliveryStatus,
    required this.style,
    this.showMessageStatus = true,
    this.date,
    this.detailWidget,
  })  : assert((date != null || detailWidget != null)),
        super(key: key);

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
