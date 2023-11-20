class DSInteractiveListMessageRow {
  final String? title;

  DSInteractiveListMessageRow({
    this.title,
  });

  DSInteractiveListMessageRow.fromJson(Map<String, dynamic> json)
      : title = json['title'];

  Map<String, dynamic> toJson() => {
        'title': title,
      };
}
