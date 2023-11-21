/// A Design System select options model used with [DSSelectMenu], [DSQuickReply] to display a options menu
class DSSelectOption {
  String text;
  int? order;
  String? type;
  dynamic value;

  DSSelectOption({
    required this.text,
    this.order,
    this.type,
    this.value,
  });

  factory DSSelectOption.fromJson(Map<String, dynamic> json) {
    final option = DSSelectOption(
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
