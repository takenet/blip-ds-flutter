class DSActiveMessageTemplate {
  const DSActiveMessageTemplate({
    this.name,
    this.language,
    this.components,
  });

  final String? name;
  final Map<String, dynamic>? language;
  final List<Map<String, dynamic>>? components;

  factory DSActiveMessageTemplate.fromJson(Map<String, dynamic> json) {
    return DSActiveMessageTemplate(
      name: json['name'],
      language: (json['language'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value),
      ),
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
