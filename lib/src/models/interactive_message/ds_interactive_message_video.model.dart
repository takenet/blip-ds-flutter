class DSInteractiveMessageVideo {
  final String? link;

  DSInteractiveMessageVideo({
    this.link,
  });

  DSInteractiveMessageVideo.fromJson(Map<String, dynamic> json)
      : link = json['link'];

  Map<String, dynamic> toJson() => {
        'link': link,
      };
}
