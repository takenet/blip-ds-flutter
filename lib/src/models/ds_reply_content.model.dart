class DSReplyContent {
  DSReplyContentReplied replied;
  DSReplyContentInReplyTo inReplyTo;

  DSReplyContent({
    required this.replied,
    required this.inReplyTo,
  });

  DSReplyContent.fromJson(Map<String, dynamic> json)
      : replied = DSReplyContentReplied.fromJson(json['replied']),
        inReplyTo = DSReplyContentInReplyTo.fromJson(json['inReplyTo']);
}

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
}
