class DSInteractiveMessageBody {
  final String? text;

  DSInteractiveMessageBody({
    this.text,
  });

  DSInteractiveMessageBody.fromJson(Map<String, dynamic> json)
      : text = json['text'];

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
