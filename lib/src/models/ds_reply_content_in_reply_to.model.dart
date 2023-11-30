class DSReplyContentInReplyTo {
  String id;
  String type;
  dynamic value;
  String direction;

  DSReplyContentInReplyTo({
    required this.id,
    required this.type,
    required this.value,
    required this.direction,
  });

  DSReplyContentInReplyTo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        value = json['value'],
        direction = json['direction'];
}
