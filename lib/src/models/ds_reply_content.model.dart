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
      : replied = DSReplyContentReplied.fromJson(
          json['replied'],
        ),
        inReplyTo = DSReplyContentInReplyTo.fromJson(
          json['inReplyTo'],
        );
}
