import 'package:blip_ds/blip_ds.dart';

/// A Design System message model used with [DSGroupCard] to display grouped bubble
class DSMessageItemModel {
  /// Identifier of message
  String? id;

  /// Date formated as isodate (Ex: 2020-01-06T13:55:46.834Z)
  String date;

  /// Date used on message list
  String displayDate;

  /// Used to set the bubble position
  DSAlign align;

  /// Allows set the status of message
  DSDeliveryReportStatus status;

  /// The message type
  String type;

  /// The message content
  dynamic content;

  /// Customer data
  Map<String, dynamic>? customer;

  /// Used to define if a message detail (typicament a messages date and time) should be displayed or not
  bool? hideMessageDetail;

  /// Creates a new Design System's [DSMessageItemModel] model
  DSMessageItemModel({
    this.id,
    required this.date,
    required this.displayDate,
    required this.align,
    required this.type,
    required this.status,
    this.content,
    this.customer,
    this.hideMessageDetail,
  });

  factory DSMessageItemModel.fromJson(Map<String, dynamic> json) {
    final messageItem = DSMessageItemModel(
      id: json['id'],
      date: json['date'],
      displayDate: json['displayDate'],
      align: json['align'] == "left" ? DSAlign.left : DSAlign.right,
      type: json['type'],
      content: json['content'],
      status: DSDeliveryReportStatus.unknown.getValue(json['status']),
      hideMessageDetail: json['hideMessageDetail'],
    );

    if (json.containsKey('customer')) {
      messageItem.customer = json['customer'];
    }

    if (json.containsKey('hideMessageDetail')) {
      messageItem.hideMessageDetail = json['hideMessageDetail'];
    }

    return messageItem;
  }
}
