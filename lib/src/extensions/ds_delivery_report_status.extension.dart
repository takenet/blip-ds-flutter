import 'package:blip_ds/blip_ds.dart';

extension DSDeliveryReportStatusExtension on DSDeliveryReportStatus {
  DSDeliveryReportStatus getValue(String value) =>
      DSDeliveryReportStatus.values.firstWhere((e) => e.name == value,
          orElse: () => DSDeliveryReportStatus.unknown);
}
