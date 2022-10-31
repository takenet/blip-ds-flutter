import 'package:blip_ds/src/enums/ds_delivery_report_status.enum.dart';
import 'package:blip_ds/src/widgets/chat/ds_delivery_report_icon.widget.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

class DSChatTestUtils {
  static const deliveryReportIconGoldenPath =
      'ds_delivery_report_icon/ds_delivery_report_icon';
  static const unsupportedContentGoldenPath =
      'ds_unsupported_content_message_bubble/ds_unsupported_content_message_bubble.';

  static GoldenBuilder createDeliveryReportIconScenarios() {
    final builder = GoldenBuilder.column();

    builder.addScenario(
      'DSDeliveryReportStatus - Accepted',
      buildDeliveryReportIcon(
        deliveryStatus: DSDeliveryReportStatus.accepted,
      ),
    );

    builder.addScenario(
      'DSDeliveryReportStatus - Consumed',
      buildDeliveryReportIcon(
        deliveryStatus: DSDeliveryReportStatus.consumed,
      ),
    );

    builder.addScenario(
      'DSDeliveryReportStatus - Received',
      buildDeliveryReportIcon(
        deliveryStatus: DSDeliveryReportStatus.received,
      ),
    );

    builder.addScenario(
      'DSDeliveryReportStatus - Failed',
      buildDeliveryReportIcon(
        deliveryStatus: DSDeliveryReportStatus.failed,
      ),
    );

    builder.addScenario(
      'DSDeliveryReportStatus - Unknown',
      buildDeliveryReportIcon(
        deliveryStatus: DSDeliveryReportStatus.unknown,
      ),
    );

    return builder;
  }

  static DSDeliveryReportIcon buildDeliveryReportIcon({
    required final DSDeliveryReportStatus deliveryStatus,
  }) {
    return DSDeliveryReportIcon(
      deliveryStatus: deliveryStatus,
    );
  }
}
