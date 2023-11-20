import 'ds_interactive_list_message_action.model.dart';
import 'ds_interactive_list_message_body.model.dart';
import 'ds_interactive_list_message_footer.model.dart';

class DSInteractiveListMessage {
  final DSInteractiveListMessageBody? body;
  final DSInteractiveListMessageAction? action;
  final DSInteractiveListMessageFooter? footer;

  DSInteractiveListMessage({
    this.body,
    this.action,
    this.footer,
  });

  DSInteractiveListMessage.fromJson(Map<String, dynamic> json)
      : body = json['body'] != null
            ? DSInteractiveListMessageBody.fromJson(json['body'])
            : null,
        action = json['action'] != null
            ? DSInteractiveListMessageAction.fromJson(json['action'])
            : null,
        footer = json['footer'] != null
            ? DSInteractiveListMessageFooter.fromJson(json['footer'])
            : null;

  Map<String, dynamic> toJson() => {
        'body': body?.toJson(),
        'action': action?.toJson(),
        'footer': footer?.toJson(),
      };
}
