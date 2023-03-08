import 'ds_media_link.model.dart';

/// A Design System document select model used with [DSDocumentSelect], to display a options menu with image
class DSDocumentSelectModel {
  DSDocumentSelectHeaderModel header;
  List<DSDocumentSelectOption> options;

  DSDocumentSelectModel({
    required this.header,
    required this.options,
  });

  factory DSDocumentSelectModel.fromJson(Map<String, dynamic> json) {
    final list = json['options'] as List;

    List<DSDocumentSelectOption> options =
        list.map((e) => DSDocumentSelectOption.fromJson(e)).toList();

    return DSDocumentSelectModel(
      header: DSDocumentSelectHeaderModel.fromJson(json['header']),
      options: options,
    );
  }
}

class DSDocumentSelectHeaderModel {
  String type;
  DSMediaLinkModel mediaLink;

  DSDocumentSelectHeaderModel({
    required this.type,
    required this.mediaLink,
  });

  factory DSDocumentSelectHeaderModel.fromJson(Map<String, dynamic> json) {
    DSMediaLinkModel mediaLink = DSMediaLinkModel.fromJson(json['value']);

    final header =
        DSDocumentSelectHeaderModel(type: json['type'], mediaLink: mediaLink);

    return header;
  }
}

class DSDocumentSelectOption {
  DSDocumentSelectValue label;
  DSDocumentSelectValue? value;

  DSDocumentSelectOption({required this.label, this.value});

  factory DSDocumentSelectOption.fromJson(Map<String, dynamic> json) {
    return DSDocumentSelectOption(
      label:
          DSDocumentSelectValue(json['label']['type'], json['label']['value']),
      value: json.containsKey('value') && json['value'] != null
          ? DSDocumentSelectValue(json['value']['type'], json['value']['value'])
          : null,
    );
  }
}

class DSDocumentSelectValue {
  String type;
  dynamic value;

  DSDocumentSelectValue(
    this.type,
    this.value,
  );
}
