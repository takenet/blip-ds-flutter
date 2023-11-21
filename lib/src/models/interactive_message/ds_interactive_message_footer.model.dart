class DSInteractiveMessageFooter {
  final String? text;

  DSInteractiveMessageFooter({
    this.text,
  });

  DSInteractiveMessageFooter.fromJson(Map<String, dynamic> json)
      : text = json['text'];

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
