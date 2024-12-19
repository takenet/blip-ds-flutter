import '../enums/ds_align.enum.dart';
import '../enums/ds_delivery_report_status.enum.dart';

/// A Design System message model used with [DSGroupCard] to display grouped bubble
class DSMessageItem {
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

  /// if the media message is uploading
  bool isUploading;

  /// Message metadata
  Map<String, dynamic>? metadata;

  /// Creates a new Design System's [DSMessageItemModel] model
  DSMessageItem({
    this.id,
    required this.date,
    required this.displayDate,
    required this.align,
    required this.type,
    required this.status,
    this.content,
    this.customer,
    this.hideMessageDetail,
    this.isUploading = false,
    this.metadata,
  });

  factory DSMessageItem.fromJson(Map<String, dynamic> json) {
    final messageItem = DSMessageItem(
      id: json['id'],
      date: json['date'],
      displayDate: json['displayDate'],
      align: json['align'] == "left" ? DSAlign.left : DSAlign.right,
      type: json['type'],
      content: json['content'],
      status: DSDeliveryReportStatus.unknown.getValue(json['status']),
      hideMessageDetail: json['hideMessageDetail'],
      isUploading: json['isUploading'] ?? false,
    );

    if (json.containsKey('customer')) {
      messageItem.customer = json['customer'];
    }

    if (json.containsKey('hideMessageDetail')) {
      messageItem.hideMessageDetail = json['hideMessageDetail'];
    }

    if (json.containsKey('metadata')) {
      messageItem.metadata = json['metadata'];
    }

    return messageItem;
  }
}
