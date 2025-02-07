import '../utils/ds_message_content_type.util.dart';
import 'ds_reply_content_in_reply_to.model.dart';
import 'ds_reply_content_replied.model.dart';

class DSReplyContent {
  DSReplyContentReplied replied;
  DSReplyContentInReplyTo inReplyTo;

  DSReplyContent({
    required this.replied,
    required this.inReplyTo,
  });

  DSReplyContent.fromJson(Map<String, dynamic> json)
      : replied = _getContent(json),
        inReplyTo = DSReplyContentInReplyTo.fromJson(
          json['inReplyTo'] ?? json['inReactionTo'],
        );

  Map<String, dynamic> toJson() {
    return {
      'replied': replied.toJson(),
      'inReplyTo': inReplyTo.toJson(),
    };
  }

  static DSReplyContentReplied _getContent(Map<String, dynamic> json) =>
      json['replied'] != null
          ? DSReplyContentReplied.fromJson(
              json['replied'],
            )
          : DSReplyContentReplied(
              type: DSMessageContentType.textPlain,
              value: String.fromCharCodes(
                (json['emoji']['values'] as List).map(
                  (e) => e as int,
                ),
              ),
            );
}
