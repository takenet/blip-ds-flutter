class DSReplyContentReplied {
  String type;
  dynamic value;

  DSReplyContentReplied({
    required this.type,
    required this.value,
  });

  DSReplyContentReplied.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        value = json['value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (type.isNotEmpty) {
      data['type'] = type;
    }

    if (value != null) {
      data['value'] = value;
    }

    return data;
  }
}
