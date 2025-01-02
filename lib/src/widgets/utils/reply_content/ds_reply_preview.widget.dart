import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../models/ds_location.model.dart';
import '../../../models/ds_media_link.model.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../utils/ds_message_content_type.util.dart';
import 'ds_json_reply_content.widget.dart';
import 'ds_location_reply_content.widget.dart';
import 'ds_media_reply_content.widget.dart';
import 'ds_plain_text_reply_content.widget.dart';
import 'ds_select_reply_content.widget.dart';
import 'ds_unsupported_reply_content.widget.dart';

class DSReplyPreview extends StatelessWidget {
  DSReplyPreview({
    super.key,
    required this.align,
    this.type,
    this.content,
    this.simpleStyle = false,
    this.isPreview = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSAlign align;
  final String? type;
  final dynamic content;
  final bool simpleStyle;
  final bool isPreview;
  final DSMessageBubbleStyle style;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      DSMessageContentType.textPlain => _buildTextPlain(),
      DSMessageContentType.select => _buidSelect(),
      DSMessageContentType.mediaLink => _buildMediaLink(),
      DSMessageContentType.applicationJson => _buildApplicationJson(),
      DSMessageContentType.location => _buidLocation(),
      _ => _buildDefault(),
    };
  }

  Widget _buildTextPlain() => DSPlainTextReplyContent(
        align: align,
        content: content,
        isPreview: isPreview,
        style: style,
      );

  Widget _buidSelect() => DSSelectReplyContent(
        align: align,
        content: content['text'],
        isPreview: isPreview,
        style: style,
      );

  Widget _buildApplicationJson() => DSJsonReplyContent(
        align: align,
        type: type,
        content: content,
        simpleStyle: simpleStyle,
        isPreview: isPreview,
        style: style,
      );

  Widget _buildMediaLink() => DSMediaReplyContent(
        align: align,
        media: DSMediaLink.fromJson(content),
        style: style,
        isPreview: isPreview,
        shouldAuthenticate: false,
      );

  Widget _buidLocation() => DSLocationReplyContent(
        align: align,
        location: DSLocation.fromJson(content),
        simpleStyle: simpleStyle,
        isPreview: isPreview,
        style: style,
      );

  Widget _buildDefault() => DSUnsupportedReplyContent(
        align: align,
        style: style,
      );
}
