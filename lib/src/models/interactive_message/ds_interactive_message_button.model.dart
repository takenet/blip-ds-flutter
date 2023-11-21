class DSInteractiveMessageButton {
  final String? title;

  DSInteractiveMessageButton({
    this.title,
  });

  DSInteractiveMessageButton.fromJson(Map<String, dynamic> json)
      : title = json['reply']?['title'];

  Map<String, dynamic> toJson() => {
        'title': title,
      };
}
