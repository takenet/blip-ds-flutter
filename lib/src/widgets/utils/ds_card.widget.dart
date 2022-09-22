import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/utils/ds_message_content_type.util.dart';
import 'package:blip_ds/src/widgets/chat/ds_quick_reply.widget.dart';

/// A Design System widget used to display a Design System's widget based in LIME protocol content types
class DSCard extends StatelessWidget {
  final String type;
  final dynamic content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final String? customerName;
  final Function? onSelected;
  final bool hideOptions;
  final DSMessageBubbleStyle style;

  /// Creates a new [DSCard] widget
  DSCard({
    Key? key,
    required this.type,
    required this.content,
    required this.align,
    required this.borderRadius,
    this.customerName,
    this.onSelected,
    required this.hideOptions,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _resolveWidget();
  }

  Widget _resolveWidget() {
    switch (type) {
      case DSMessageContentType.textPlain:
      case DSMessageContentType.sensitive:
        return DSTextMessageBubble(
          text: content is String ? content : '**********',
          align: align,
          borderRadius: borderRadius,
          style: style,
        );

      case DSMessageContentType.mediaLink:
        return _buildMediaLink();

      case DSMessageContentType.select:
        return _buildSelect();

      default:
        return DSUnsupportedContentMessageBubble(
          align: align,
          borderRadius: borderRadius,
          style: style,
        );
    }
  }

  Widget _buildSelect() {
    return content['scope'] == 'immediate'
        ? DSQuickReply(
            align: align,
            content: content,
            onSelected: onSelected,
            hideOptions: hideOptions,
            // style: style,
          )
        : DSTextMessageBubble(
            align: align,
            text: content['text'],
            borderRadius: borderRadius,
            selectContent: content,
            showSelect: true,
            onSelected: onSelected,
            style: style,
          );
  }

  Widget _buildMediaLink() {
    final String contentType = content['type'];

    if (contentType.contains('audio')) {
      return DSAudioMessageBubble(
        uri: content['uri'],
        align: align,
        borderRadius: borderRadius,
        style: style,
      );
    } else if (contentType.contains('image')) {
      return DSImageMessageBubble(
        url: content['uri'],
        align: align,
        appBarText: customerName ?? '',
        text: content['text'],
        title: content['title'],
        borderRadius: borderRadius,
        style: style,
      );
    } else if (contentType.contains('video')) {
      return DSVideoMessageBubble(
        url: content['uri'],
        align: align,
        appBarText: customerName ?? '',
        text: content['text'],
        borderRadius: borderRadius,
        style: style,
      );
    } else {
      return DSFileMessageBubble(
        align: align,
        url: content['uri'],
        size: content['size'],
        filename: content['title'],
        borderRadius: borderRadius,
        style: style,
      );
    }
  }
}
