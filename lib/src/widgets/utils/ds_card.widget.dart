import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_ticket_message_type.enum.dart';
import '../../models/ds_document_select.model.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../chat/audio/ds_audio_message_bubble.widget.dart';
import '../chat/ds_carrousel.widget.dart';
import '../chat/ds_contact_message_bubble.widget.dart';
import '../chat/ds_file_message_bubble.widget.dart';
import '../chat/ds_image_message_bubble.widget.dart';
import '../chat/ds_quick_reply.widget.dart';
import '../chat/ds_text_message_bubble.widget.dart';
import '../chat/ds_unsupported_content_message_bubble.widget.dart';
import '../chat/ds_weblink.widget.dart';
import '../chat/video/ds_video_message_bubble.widget.dart';
import '../ticket_message/ds_ticket_message.widget.dart';

/// A Design System widget used to display a Design System's widget based in LIME protocol content types
class DSCard extends StatelessWidget {
  /// Creates a new [DSCard] widget
  DSCard({
    super.key,
    required this.type,
    required this.content,
    required this.align,
    required this.borderRadius,
    this.onSelected,
    this.onOpenLink,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    DSMessageBubbleStyle? style,
    this.messageId,
    this.showQuickReplyOptions = false,
  }) : style = style ?? DSMessageBubbleStyle();

  final String type;
  final dynamic content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;
  final DSMessageBubbleAvatarConfig avatarConfig;
  final DSMessageBubbleStyle style;
  final String? messageId;
  final bool showQuickReplyOptions;

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

      case DSMessageContentType.contact:
        return _buildContact();
      case DSMessageContentType.mediaLink:
        return _buildMediaLink();

      case DSMessageContentType.select:
        return _buildSelect();

      case DSMessageContentType.documentSelect:
        return _buildDocumentSelect();

      case DSMessageContentType.collection:
        return DSCarrousel(
          align: align,
          content: content,
          borderRadius: borderRadius,
          onSelected: onSelected,
          onOpenLink: onOpenLink,
          avatarConfig: avatarConfig,
          style: style,
        );

      case DSMessageContentType.webLink:
        return DSWeblink(
          title: content['title'],
          text: content['text'],
          url: content['uri'],
          align: align,
          borderRadius: borderRadius,
          style: style,
        );

      case DSMessageContentType.ticket:
        return DSTicketMessage(
          messageType: DSTicketMessageType.forwardedTicket,
          ticketId: content['formattedTicketId'],
          chatbotIdentity: content['ownerIdentity'],
        );

      default:
        return DSUnsupportedContentMessageBubble(
          align: align,
          borderRadius: borderRadius,
          style: style,
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
      appBarText: (align == DSAlign.left
              ? avatarConfig.receivedName
              : avatarConfig.sentName) ??
          '',
      appBarPhotoUri: align == DSAlign.left
          ? avatarConfig.receivedAvatar
          : avatarConfig.sentAvatar,
      selectOptions: documentSelectModel.options,
      borderRadius: borderRadius,
      style: style,
      showSelect: true,
      onSelected: onSelected,
      onOpenLink: onOpenLink,
    );
  }

  Widget _buildSelect() {
    return content['scope'] == 'immediate'
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: showQuickReplyOptions ? 16.0 : 0.0,
                ),
                child: DSTextMessageBubble(
                  align: align,
                  text: content['text'],
                  borderRadius: borderRadius,
                  style: style,
                ),
              ),
              Visibility(
                visible: showQuickReplyOptions,
                child: DSQuickReply(
                  key: const ValueKey('ds-quick-reply'),
                  align: align,
                  content: content,
                  onSelected: onSelected,
                ),
              ),
            ],
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

  Widget _buildContact() {
    return DSContactMessageBubble(
      name: content['name'],
      phone: content['cellPhoneNumber'],
      address: content['address'],
      email: content['email'],
      align: align,
      style: style,
      borderRadius: borderRadius,
    );
  }

  Widget _buildMediaLink() {
    final String contentType = content['type'];

    if (contentType.contains('audio')) {
      return DSAudioMessageBubble(
        uri: Uri.parse(content['uri']),
        align: align,
        borderRadius: borderRadius,
        style: style,
        uniqueId: messageId,
        audioType: content['type'],
      );
    } else if (contentType.contains('image')) {
      return DSImageMessageBubble(
        url: content['uri'],
        align: align,
        appBarText: (align == DSAlign.left
                ? avatarConfig.receivedName
                : avatarConfig.sentName) ??
            '',
        appBarPhotoUri: align == DSAlign.left
            ? avatarConfig.receivedAvatar
            : avatarConfig.sentAvatar,
        text: content['text'],
        title: content['title'],
        borderRadius: borderRadius,
        style: style,
      );
    } else if (contentType.contains('video')) {
      return DSVideoMessageBubble(
        url: content['uri'],
        align: align,
        appBarText: (align == DSAlign.left
                ? avatarConfig.receivedName
                : avatarConfig.sentName) ??
            '',
        appBarPhotoUri: align == DSAlign.left
            ? avatarConfig.receivedAvatar
            : avatarConfig.sentAvatar,
        text: content['text'],
        borderRadius: borderRadius,
        style: style,
        uniqueId: messageId ?? DateTime.now().toIso8601String(),
        mediaSize: content.containsKey('size') ? content['size'] : 0,
      );
    } else {
      return DSFileMessageBubble(
        align: align,
        url: content['uri'],
        size: content.containsKey('size') ? content['size'] : 0,
        filename: content['title'],
        borderRadius: borderRadius,
        style: style,
      );
    }
  }
}
