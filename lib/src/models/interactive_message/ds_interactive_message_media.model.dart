abstract class DSInteractiveMessageMedia {
  final String? link;

  DSInteractiveMessageMedia({
    this.link,
  });

  DSInteractiveMessageMedia.fromJson(Map<String, dynamic> json)
      : link = json['link'];

  Map<String, dynamic> toJson() => {
        'link': link,
      };
}
