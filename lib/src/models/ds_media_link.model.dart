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
        type = _formatMimeType(
          type: json['type'],
        ),
        title = json['title'],
        text = json['text'],
        aspectRatio = json['aspectRatio'],
        size = json['size'],
        authorizationRealm = json['authorizationRealm'],
        previewUri = json['previewUri'];

  static String _formatMimeType({
    required final String? type,
  }) =>
      type?.toLowerCase().replaceFirst('sticker/', 'image/') ?? '';
}
