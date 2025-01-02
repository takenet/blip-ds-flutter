class DSReplyContentInReplyTo {
  String? id;
  String? type;
  dynamic value;
  String? direction;

  DSReplyContentInReplyTo({
    required this.id,
    required this.type,
    required this.value,
    required this.direction,
  });

  DSReplyContentInReplyTo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'] ?? '',
        value = json['value'] ?? '',
        direction = json['direction'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (id != null) {
      data['id'] = id;
    }

    if (type != null) {
      data['type'] = type;
    }

    if (value != null) {
      data['value'] = value;
    }

    if (direction != null) {
      data['direction'] = direction;
    }

    return data;
  }
}
