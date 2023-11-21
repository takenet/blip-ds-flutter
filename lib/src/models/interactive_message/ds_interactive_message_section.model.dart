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
        rows = json['rows'] != null
            ? List.from(json['rows'])
                .map(
                  (e) => DSInteractiveMessageRow.fromJson(e),
                )
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'title': title,
        'rows': rows
            ?.map(
              (e) => e.toJson(),
            )
            .toList(),
      };
}
