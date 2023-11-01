import '../enums/ds_delivery_report_status.enum.dart';

extension DSDeliveryReportStatusExtension on DSDeliveryReportStatus {
  DSDeliveryReportStatus getValue(String value) =>
      DSDeliveryReportStatus.values.firstWhere((e) => e.name == value,
          orElse: () => DSDeliveryReportStatus.unknown);
}
