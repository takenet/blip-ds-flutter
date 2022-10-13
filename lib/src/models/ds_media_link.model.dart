class DSMediaLinkModel {
  String? title;
  String? text;
  String type;
  String uri;
  String? aspectRatio;

  DSMediaLinkModel({
    required this.uri,
    required this.type,
  });

  factory DSMediaLinkModel.fromJson(Map<String, dynamic> json) {
    final mediaLink = DSMediaLinkModel(
      uri: json['uri'],
      type: json['type'],
    );

    if (json.containsKey('title')) {
      mediaLink.title = json['title'];
    }

    if (json.containsKey('text')) {
      mediaLink.text = json['text'];
    }

    if (json.containsKey('aspectRatio')) {
      mediaLink.aspectRatio = json['aspectRatio'];
    }

    return mediaLink;
  }
}
