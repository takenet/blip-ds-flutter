import 'package:blip_ds/src/widgets/chat/ds_quick_reply.widget.dart';
import 'package:blip_ds/src/widgets/chat/ds_select_menu.widget.dart';

/// A Design System select options model used with [DSSelectMenu], [DSQuickReply] to display a options menu
class DSSelectOptionModel {
  String text;
  int? order;
  String? type;
  dynamic value;

  DSSelectOptionModel({
    required this.text,
    this.order,
    this.type,
    this.value,
  });

  factory DSSelectOptionModel.fromJson(Map<String, dynamic> json) {
    final option = DSSelectOptionModel(
      text: json['text'],
    );

    if (json.containsKey('order')) {
      option.order = json['order'];
    }

    if (json.containsKey('type')) {
      option.type = json['type'];
    }

    if (json.containsKey('value')) {
      option.value = json['value'];
    }

    return option;
  }
}
