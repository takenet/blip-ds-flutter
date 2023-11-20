import 'ds_interactive_list_message_row.model.dart';

class DSInteractiveListMessageSection {
  final List<DSInteractiveListMessageRow>? rows;

  DSInteractiveListMessageSection({
    this.rows,
  });

  DSInteractiveListMessageSection.fromJson(Map<String, dynamic> json)
      : rows = List.from(json['rows'])
            .map(
              (e) => DSInteractiveListMessageRow.fromJson(e),
            )
            .toList();

  Map<String, dynamic> toJson() => {
        'rows': rows
            ?.map(
              (e) => e.toJson(),
            )
            .toList(),
      };
}
