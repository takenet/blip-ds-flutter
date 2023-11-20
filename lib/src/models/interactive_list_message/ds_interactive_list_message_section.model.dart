import 'ds_interactive_list_message_row.model.dart';

class DSInteractiveListMessageSection {
  final String? title;
  final List<DSInteractiveListMessageRow>? rows;

  DSInteractiveListMessageSection({
    this.title,
    this.rows,
  });

  DSInteractiveListMessageSection.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        rows = List.from(json['rows'])
            .map(
              (e) => DSInteractiveListMessageRow.fromJson(e),
            )
            .toList();

  Map<String, dynamic> toJson() => {
        'title': title,
        'rows': rows
            ?.map(
              (e) => e.toJson(),
            )
            .toList(),
      };
}
