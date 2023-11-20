class DSInteractiveListMessageBody {
  final String? text;

  DSInteractiveListMessageBody({
    this.text,
  });

  DSInteractiveListMessageBody.fromJson(Map<String, dynamic> json)
      : text = json['text'];

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
