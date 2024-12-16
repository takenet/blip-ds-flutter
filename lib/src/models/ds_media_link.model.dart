class DSMediaLink {
  String? title;
  String? text;
  String type;
  String uri;
  String? aspectRatio;
  int? size;
  String? authorizationRealm;
  String? previewUri;

  DSMediaLink({
    required this.uri,
    required this.type,
    this.title,
    this.text,
    this.aspectRatio,
    this.size,
    this.authorizationRealm,
    this.previewUri,
  });

  DSMediaLink.fromJson(Map<String, dynamic> json)
      : uri = json['uri'],
        type = json['type'],
        title = json['title'],
        text = json['text'],
        aspectRatio = json['aspectRatio'],
        size = json['size'],
        authorizationRealm = json['authorizationRealm'],
        previewUri = json['previewUri'];
}
