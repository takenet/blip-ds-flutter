import 'package:blip_ds/blip_ds.dart';

class DSMessageItemModel {
  String date;
  DSAlign align;
  DSDeliveryReportStatus status;
  String type;
  dynamic content;

  DSMessageItemModel(
      {required this.date,
      required this.align,
      required this.type,
      required this.status,
      this.content});
}
