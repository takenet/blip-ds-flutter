import 'ds_interactive_message_button.model.dart';
import 'ds_interactive_message_parameters.model.dart';
import 'ds_interactive_message_section.model.dart';

class DSInteractiveMessageAction {
  final String? button;
  final List<DSInteractiveMessageButton>? buttons;
  final List<DSInteractiveMessageSection>? sections;
  final String? name;
  final DSInteractiveMessageParameters? parameters;

  DSInteractiveMessageAction({
    this.button,
    this.buttons,
    this.sections,
    this.name,
    this.parameters,
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
            : null,
        name = json['name'],
        parameters = DSInteractiveMessageParameters.fromJson(
          json['parameters'],
        );

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
        'name': name,
        'parameters': parameters,
      };
}
