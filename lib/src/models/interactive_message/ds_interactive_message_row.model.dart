class DSInteractiveMessageRow {
  final String? title;

  DSInteractiveMessageRow({
    this.title,
  });

  DSInteractiveMessageRow.fromJson(Map<String, dynamic> json)
      : title = json['title'];

  Map<String, dynamic> toJson() => {
        'title': title,
      };
}
