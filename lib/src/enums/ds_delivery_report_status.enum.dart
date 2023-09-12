export 'package:blip_ds/src/extensions/ds_delivery_report_status.extension.dart';

/// A Design System's enum that can be used to set the icon at a message detail delivery report.
enum DSDeliveryReportStatus {
  accepted,
  received,
  consumed,
  failed,
  sending,
  unknown,
}
