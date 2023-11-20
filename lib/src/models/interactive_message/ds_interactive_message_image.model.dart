class DSInteractiveMessageImage {
  final String? link;

  DSInteractiveMessageImage({
    this.link,
  });

  DSInteractiveMessageImage.fromJson(Map<String, dynamic> json)
      : link = json['link'];

  Map<String, dynamic> toJson() => {
        'link': link,
      };
}
