import 'ds_interactive_message_action.model.dart';
import 'ds_interactive_message_body.model.dart';
import 'ds_interactive_message_footer.model.dart';
import 'ds_interactive_message_header.model.dart';

class DSInteractiveMessage {
  final DSInteractiveMessageHeader? header;
  final DSInteractiveMessageBody? body;
  final DSInteractiveMessageAction? action;
  final DSInteractiveMessageFooter? footer;

  DSInteractiveMessage({
    this.header,
    this.body,
    this.action,
    this.footer,
  });

  DSInteractiveMessage.fromJson(Map<String, dynamic> json)
      : header = json['header'] != null
            ? DSInteractiveMessageHeader.fromJson(json['header'])
            : null,
        body = json['body'] != null
            ? DSInteractiveMessageBody.fromJson(json['body'])
            : null,
        action = json['action'] != null
            ? DSInteractiveMessageAction.fromJson(json['action'])
            : null,
        footer = json['footer'] != null
            ? DSInteractiveMessageFooter.fromJson(json['footer'])
            : null;

  Map<String, dynamic> toJson() => {
        'body': body?.toJson(),
        'action': action?.toJson(),
        'footer': footer?.toJson(),
      };
}
