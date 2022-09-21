import 'package:blip_ds/src/models/ds_media_link.model.dart';
import 'package:blip_ds/src/widgets/chat/typing/ds_document_select.widget.dart';

/// A Design System document select model used with [DSDocumentSelect], to display a options menu with image
class DSDocumentSelectModel {
  DSDocumentSelectHeaderModel header;
  List options;

  DSDocumentSelectModel({
    required this.header,
    required this.options,
  });

  factory DSDocumentSelectModel.fromJson(Map<String, dynamic> json) {
    final documentSelectModel = DSDocumentSelectModel(
      header: DSDocumentSelectHeaderModel.fromJson(json['header']),
      options: json['options'],
    );

    return documentSelectModel;
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
