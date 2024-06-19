import 'ds_interactive_message_media.model.dart';

class DSInteractiveMessageDocument extends DSInteractiveMessageMedia {
  final String? filename;

  DSInteractiveMessageDocument({
    super.link,
    this.filename,
  });

  DSInteractiveMessageDocument.fromJson(super.json)
      : filename = json['filename'],
        super.fromJson();

  @override
  Map<String, dynamic> toJson() => {
        'link': super.link,
        'filename': filename,
      };
}
