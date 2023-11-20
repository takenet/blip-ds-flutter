import 'ds_interactive_message_row.model.dart';

class DSInteractiveMessageSection {
  final String? title;
  final List<DSInteractiveMessageRow>? rows;

  DSInteractiveMessageSection({
    this.title,
    this.rows,
  });

  DSInteractiveMessageSection.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        rows = List.from(json['rows'])
            .map(
              (e) => DSInteractiveMessageRow.fromJson(e),
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
