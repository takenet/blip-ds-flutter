class DSActiveMessageTemplateContent {
  const DSActiveMessageTemplateContent({
    this.name,
    this.language,
    this.components,
  });

  final String? name;
  final String? language;
  final List<Map<String, dynamic>>? components;

  factory DSActiveMessageTemplateContent.fromJson(Map<String, dynamic> json) {
    return DSActiveMessageTemplateContent(
      name: json['name'],
      language: json['language'],
      components: (json['components'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'language': language,
      'components': components,
    };
  }
}
