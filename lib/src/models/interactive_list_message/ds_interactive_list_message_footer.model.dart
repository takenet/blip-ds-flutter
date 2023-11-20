class DSInteractiveListMessageFooter {
  final String? text;

  DSInteractiveListMessageFooter({
    this.text,
  });

  DSInteractiveListMessageFooter.fromJson(Map<String, dynamic> json)
      : text = json['text'];

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
