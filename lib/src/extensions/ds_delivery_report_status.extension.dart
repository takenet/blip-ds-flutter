import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/foundation.dart';

extension DSDeliveryReportStatusExtension on DSDeliveryReportStatus {
  DSDeliveryReportStatus getValue(String value) =>
      DSDeliveryReportStatus.values.firstWhere((e) => describeEnum(e) == value,
          orElse: () => DSDeliveryReportStatus.unknown);
}
