import 'ds_interactive_list_message_section.model.dart';

class DSInteractiveListMessageAction {
  final String? button;
  final List<DSInteractiveListMessageSection>? sections;

  DSInteractiveListMessageAction({
    this.button,
    this.sections,
  });

  DSInteractiveListMessageAction.fromJson(Map<String, dynamic> json)
      : button = json['button'],
        sections = json['sections'] != null
            ? List.from(json['sections'])
                .map(
                  (e) => DSInteractiveListMessageSection.fromJson(e),
                )
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'button': button,
        'sections': sections
            ?.map(
              (e) => e.toJson(),
            )
            .toList(),
      };
}
