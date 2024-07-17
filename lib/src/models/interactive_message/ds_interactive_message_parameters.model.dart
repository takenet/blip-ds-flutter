class DSInteractiveMessageParameters {
  final String? displayText;

  DSInteractiveMessageParameters({
    this.displayText,
  });

  DSInteractiveMessageParameters.fromJson(Map<String, dynamic> json)
      : displayText = json['display_text'];

  Map<String, dynamic> toJson() => {
        'display_text': displayText,
      };
}
