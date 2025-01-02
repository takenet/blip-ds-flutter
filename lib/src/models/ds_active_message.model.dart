import 'ds_active_message_template.model.dart';
import 'ds_active_message_template_content.model.dart';

class DSActiveMessage {
  DSActiveMessage({
    required this.type,
    this.template,
    this.templateContent,
  });

  final String type;
  final DSActiveMessageTemplate? template;
  final DSActiveMessageTemplateContent? templateContent;

  factory DSActiveMessage.fromJson(Map<String, dynamic> json) {
    return DSActiveMessage(
      type: json['type'],
      template: json['template'] != null
          ? DSActiveMessageTemplate.fromJson(json['template'])
          : null,
      templateContent:
          DSActiveMessageTemplateContent.fromJson(json['templateContent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'template': template,
      'templateContent': templateContent,
    };
  }
}
