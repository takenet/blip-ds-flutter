import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/models/ds_document_select.model.dart';
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
  final void Function(Map<String, dynamic> payload)? onOpenLink;

  /// Creates a new [DSCard] widget
  const DSCard({
    Key? key,
    required this.type,
    required this.content,
    required this.align,
    required this.borderRadius,
    this.customerName,
    this.onSelected,
    required this.hideOptions,
    this.onOpenLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _resolveWidget();
  }

  Widget _resolveWidget() {
    switch (type) {
      case DSMessageContentType.textPlain:
        return DSTextMessageBubble(
          text: content,
          align: align,
          borderRadius: borderRadius,
        );

      case DSMessageContentType.mediaLink:
        return _buildMediaLink();

      case DSMessageContentType.select:
        return _buildSelect();

      case DSMessageContentType.documentSelect:
        return _buildDocumentSelect();

      default:
        return DSUnsupportedContentMessageBubble(
          align: align,
          borderRadius: borderRadius,
        );
    }
  }

  Widget _buildDocumentSelect() {
    final documentSelectModel = DSDocumentSelectModel.fromJson(content);

    return DSImageMessageBubble(
      align: align,
      url: documentSelectModel.header.mediaLink.uri,
      title: documentSelectModel.header.mediaLink.title!,
      text: documentSelectModel.header.mediaLink.text!,
      appBarText: customerName ?? '',
      selectOptions: documentSelectModel.options,
      showSelect: true,
      onSelected: onSelected,
      onOpenLink: onOpenLink,
    );
  }

  Widget _buildSelect() {
    return content['scope'] == 'immediate'
        ? DSQuickReply(
            align: align,
            content: content,
            onSelected: onSelected,
            hideOptions: hideOptions)
        : DSTextMessageBubble(
            align: align,
            text: content['text'],
            borderRadius: borderRadius,
            selectContent: content,
            showSelect: true,
            onSelected: onSelected,
          );
  }

  Widget _buildMediaLink() {
    final String contentType = content['type'];

    if (contentType.contains('audio')) {
      return DSAudioMessageBubble(
        uri: content['uri'],
        align: align,
        borderRadius: borderRadius,
      );
    } else if (contentType.contains('image')) {
      return DSImageMessageBubble(
        url: content['uri'],
        align: align,
        appBarText: customerName ?? '',
        text: content['text'],
        title: content['title'],
        borderRadius: borderRadius,
      );
    } else if (contentType.contains('video')) {
      return DSVideoMessageBubble(
        url: content['uri'],
        align: align,
        appBarText: customerName ?? '',
        text: content['text'],
        borderRadius: borderRadius,
      );
    } else {
      return DSFileMessageBubble(
        align: align,
        url: content['uri'],
        size: content['size'],
        filename: content['title'],
        borderRadius: borderRadius,
      );
    }
  }
}
