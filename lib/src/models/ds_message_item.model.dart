import 'package:blip_ds/blip_ds.dart';

/// A Design System message model used with [DSGroupCard] to display grouped bubble
class DSMessageItemModel {
  /// Date formated as isodate (Ex: 2020-01-06T13:55:46.834Z)
  String date;

  /// Date used on message list
  String displayDate;

  /// Used to set the bubble position
  DSAlign align;

  /// Allows set the status of message
  DSDeliveryReportStatus? status;

  /// The message type
  String type;

  /// The message content
  dynamic content;

  /// Used to display a user name and avatar at an image preview in image bubble
  String? customerName;

  /// Creates a new Design System's [DSMessageItemModel] model
  DSMessageItemModel(
      {required this.date,
      required this.displayDate,
      required this.align,
      required this.type,
      this.status,
      this.content,
      this.customerName});

  factory DSMessageItemModel.fromJson(Map<String, dynamic> json) {
    final messageItem = DSMessageItemModel(
        date: json['date'],
        displayDate: json['displayDate'],
        align: json['align'],
        type: json['type'],
        content: json['content']);

    if (json.containsKey('customerName')) {
      messageItem.customerName = json['customerName'];
    }

    if (json.containsKey('status')) {
      messageItem.status = json['status'];
    }

    return messageItem;
  }
}
