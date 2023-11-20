class DSInteractiveMessageDocument {
  final String? link;
  final String? filename;

  DSInteractiveMessageDocument({
    this.link,
    this.filename,
  });

  DSInteractiveMessageDocument.fromJson(Map<String, dynamic> json)
      : link = json['link'],
        filename = json['filename'];

  Map<String, dynamic> toJson() => {
        'link': link,
        'filename': filename,
      };
}
