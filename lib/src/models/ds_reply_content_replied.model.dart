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
