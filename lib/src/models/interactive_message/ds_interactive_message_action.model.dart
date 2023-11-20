import 'ds_interactive_message_button.model.dart';
import 'ds_interactive_message_section.model.dart';

class DSInteractiveMessageAction {
  final String? button;
  final List<DSInteractiveMessageButton>? buttons;
  final List<DSInteractiveMessageSection>? sections;

  DSInteractiveMessageAction({
    this.button,
    this.buttons,
    this.sections,
  });

  DSInteractiveMessageAction.fromJson(Map<String, dynamic> json)
      : button = json['button'],
        buttons = json['buttons'] != null
            ? List.from(json['buttons'])
                .map(
                  (e) => DSInteractiveMessageButton.fromJson(e),
                )
                .toList()
            : null,
        sections = json['sections'] != null
            ? List.from(json['sections'])
                .map(
                  (e) => DSInteractiveMessageSection.fromJson(e),
                )
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'button': button,
        'buttons': buttons
            ?.map(
              (e) => e.toJson(),
            )
            .toList(),
        'sections': sections
            ?.map(
              (e) => e.toJson(),
            )
            .toList(),
      };
}
