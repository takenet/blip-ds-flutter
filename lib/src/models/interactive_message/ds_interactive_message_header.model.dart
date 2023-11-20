import 'package:get/get.dart';

import '../../enums/ds_interactive_message_header_type.enum.dart';
import 'ds_interactive_message_document.model.dart';
import 'ds_interactive_message_image.model.dart';
import 'ds_interactive_message_video.model.dart';

class DSInteractiveMessageHeader {
  final DSInteractiveMessageHeaderType? type;
  final String? text;
  final DSInteractiveMessageDocument? document;
  final DSInteractiveMessageImage? image;
  final DSInteractiveMessageVideo? video;

  DSInteractiveMessageHeader({
    this.type,
    this.text,
    this.document,
    this.image,
    this.video,
  });

  DSInteractiveMessageHeader.fromJson(Map<String, dynamic> json)
      : type = DSInteractiveMessageHeaderType.values.firstWhereOrNull(
          (e) => e.name == json['type'],
        ),
        text = json['text'],
        document = json['document'] != null
            ? DSInteractiveMessageDocument.fromJson(json['document'])
            : null,
        image = json['image'] != null
            ? DSInteractiveMessageImage.fromJson(json['image'])
            : null,
        video = json['video'] != null
            ? DSInteractiveMessageVideo.fromJson(json['video'])
            : null;

  Map<String, dynamic> toJson() => {
        'type': type?.name,
        'text': text,
        'document': document?.toJson(),
        'image': image?.toJson(),
        'video': video?.toJson(),
      };
}
