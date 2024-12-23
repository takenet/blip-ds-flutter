import 'dart:io';

import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_delivery_report_status.enum.dart';
import '../../enums/ds_ticket_message_type.enum.dart';
import '../../models/ds_calls_media_message.model.dart';
import '../../models/ds_document_select.model.dart';
import '../../models/ds_media_link.model.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../services/ds_file.service.dart';
import '../../utils/ds_message_content_type.util.dart';
import '../../utils/ds_utils.util.dart';
import '../chat/audio/ds_audio_message_bubble.widget.dart';
import '../chat/calls/ds_end_calls_message_bubble.widget.dart';
import '../chat/ds_application_json_message_bubble.widget.dart';
import '../chat/ds_carrousel.widget.dart';
import '../chat/ds_contact_message_bubble.widget.dart';
import '../chat/ds_file_message_bubble.widget.dart';
import '../chat/ds_image_message_bubble.widget.dart';
import '../chat/ds_location_message_bubble.widget.dart';
import '../chat/ds_quick_reply.widget.dart';
import '../chat/ds_request_location_bubble.widget.dart';
import '../chat/ds_text_message_bubble.widget.dart';
import '../chat/ds_unsupported_content_message_bubble.widget.dart';
import '../chat/ds_weblink_message_bubble.widget.dart';
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
    this.status,
    this.onSelected,
    this.onOpenLink,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    DSMessageBubbleStyle? style,
    this.messageId,
    this.customer,
    this.showQuickReplyOptions = false,
    this.showRequestLocationButton = false,
    this.replyContent,
    this.isUploading = false,
    this.simpleStyle = false,
    this.onAsyncFetchSession,
    this.onTapReply,
  }) : style = style ?? DSMessageBubbleStyle();

  final String type;
  final dynamic content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSDeliveryReportStatus? status;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;
  final DSMessageBubbleAvatarConfig avatarConfig;
  final DSMessageBubbleStyle style;
  final String? messageId;
  final Map<String, dynamic>? customer;
  final bool showQuickReplyOptions;
  final bool showRequestLocationButton;
  final DSReplyContent? replyContent;
  final bool isUploading;
  final bool simpleStyle;
  final Future<String?> Function(String)? onAsyncFetchSession;
  final void Function(String)? onTapReply;

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
          replyContent: replyContent,
          simpleStyle: simpleStyle,
          onTapReply: onTapReply,
        );

      case DSMessageContentType.contact:
        return _buildContact();

      case DSMessageContentType.reply:
        final replyContent = DSReplyContent.fromJson(content);

        return DSCard(
          type: replyContent.replied.type,
          content: replyContent.replied.value,
          align: align,
          borderRadius: borderRadius,
          status: status,
          onSelected: onSelected,
          avatarConfig: avatarConfig,
          style: style,
          onOpenLink: onOpenLink,
          messageId: messageId,
          customer: customer,
          replyContent: DSUtils.shouldShowReplyContainer ? replyContent : null,
          simpleStyle: simpleStyle,
          isUploading: isUploading,
          onTapReply: onTapReply,
        );

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
          onTapReply: onTapReply,
        );

      case DSMessageContentType.webLink:
        return DSWeblinkMessageBubble(
          title: content['title'],
          text: content['text'],
          url: content['uri'],
          align: align,
          replyContent: replyContent,
          borderRadius: borderRadius,
          style: style,
          simpleStyle: simpleStyle,
          onTapReply: onTapReply,
        );

      case DSMessageContentType.location:
        return DSLocationMessageBubble(
          title: content['text'],
          latitude: content['latitude'].toString(),
          longitude: content['longitude'].toString(),
          borderRadius: borderRadius,
          align: align,
          style: style,
          replyContent: replyContent,
          simpleStyle: simpleStyle,
          onTapReply: onTapReply,
        );
      case DSMessageContentType.ticket:
        return simpleStyle
            ? const SizedBox.shrink()
            : DSTicketMessage(
                messageType: DSTicketMessageType.forwardedTicket,
                ticketId: content['formattedTicketId'],
                chatbotIdentity: content['ownerIdentity'],
                contentStatus: content['status'],
              );

      case DSMessageContentType.input:
        return _buildRequestLocation();

      case DSMessageContentType.applicationJson:
        return DSApplicationJsonMessageBubble(
          align: align,
          borderRadius: borderRadius,
          style: style,
          content: content,
          status: status,
          avatarConfig: avatarConfig,
          simpleStyle: simpleStyle,
          onTapReply: onTapReply,
        );

      case DSMessageContentType.callsMedia:
        return DSEndCallsMessageBubble(
          align: align,
          borderRadius: borderRadius,
          style: style,
          callsMediaMessage: DSCallsMediaMessage.fromJson(content),
          onAsyncFetchSession: onAsyncFetchSession,
          onTapReply: onTapReply,
        );

      default:
        return DSUnsupportedContentMessageBubble(
          align: align,
          replyContent: replyContent,
          borderRadius: borderRadius,
          style: style,
          simpleStyle: simpleStyle,
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
      replyContent: replyContent,
      showSelect: true,
      onSelected: onSelected,
      onOpenLink: onOpenLink,
      mediaType: documentSelectModel.header.mediaLink.type,
      simpleStyle: simpleStyle,
      onTapReply: onTapReply,
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
                  onTapReply: onTapReply,
                  align: align,
                  text: content['text'],
                  replyContent: replyContent,
                  borderRadius: borderRadius,
                  style: style,
                  simpleStyle: simpleStyle,
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
            onTapReply: onTapReply,
            align: align,
            text: content['text'],
            borderRadius: borderRadius,
            selectContent: content,
            showSelect: true,
            replyContent: replyContent,
            onSelected: onSelected,
            style: style,
            simpleStyle: simpleStyle,
          );
  }

  Widget _buildContact() {
    return DSContactMessageBubble(
      name: content['name'],
      phone: content['cellPhoneNumber'],
      address: content['address'],
      email: content['email'],
      align: align,
      replyContent: replyContent,
      style: style,
      borderRadius: borderRadius,
      simpleStyle: simpleStyle,
    );
  }

  Widget _buildMediaLink() {
    final media = DSMediaLink.fromJson(
      content,
    );
    final size = media.size ?? 0;

    final shouldAuthenticate =
        media.authorizationRealm?.toLowerCase() == 'blip';

    if (shouldAuthenticate &&
        (customer?['domain']?.contains('tunnel.msging.net') ?? false)) {
      media.uri = '${media.uri}?tunnel=${customer!['id']}';
    }

    if (media.type.contains('audio')) {
      return DSAudioMessageBubble(
        uri: media.uri.startsWith('http')
            ? Uri.parse(media.uri)
            : File(media.uri).uri,
        align: align,
        borderRadius: borderRadius,
        style: style,
        replyContent: replyContent,
        uniqueId: messageId,
        shouldAuthenticate: shouldAuthenticate,
        simpleStyle: simpleStyle,
        onTapReply: onTapReply,
      );
    } else if (media.type.contains('image')) {
      return DSImageMessageBubble(
        url: media.uri,
        align: align,
        appBarText: (align == DSAlign.left
                ? avatarConfig.receivedName
                : avatarConfig.sentName) ??
            '',
        appBarPhotoUri: align == DSAlign.left
            ? avatarConfig.receivedAvatar
            : avatarConfig.sentAvatar,
        text: media.text,
        title: media.title,
        replyContent: replyContent,
        borderRadius: borderRadius,
        style: style,
        shouldAuthenticate: shouldAuthenticate,
        mediaType: media.type,
        isUploading: isUploading,
        simpleStyle: simpleStyle,
        onTapReply: onTapReply,
      );
    } else if (media.type.contains('video')) {
      return DSVideoMessageBubble(
        url: media.uri,
        align: align,
        appBarText: (align == DSAlign.left
                ? avatarConfig.receivedName
                : avatarConfig.sentName) ??
            '',
        appBarPhotoUri: align == DSAlign.left
            ? avatarConfig.receivedAvatar
            : avatarConfig.sentAvatar,
        text: media.text,
        title: media.title,
        replyContent: replyContent,
        borderRadius: borderRadius,
        style: style,
        mediaSize: size,
        shouldAuthenticate: shouldAuthenticate,
        isUploading: isUploading,
        simpleStyle: simpleStyle,
        onTapReply: onTapReply,
      );
    } else {
      return DSFileMessageBubble(
        align: align,
        url: media.uri,
        text: media.text,
        replyContent: replyContent,
        size: size,
        filename: media.title ??
            '${media.uri.hashCode}.${DSFileService.getExtensionFromMimeType(media.type)}',
        borderRadius: borderRadius,
        style: style,
        shouldAuthenticate: shouldAuthenticate,
        isUploading: isUploading,
        simpleStyle: simpleStyle,
      );
    }
  }

  Widget _buildRequestLocation() {
    final label = content['label'];
    final type = label['type'];
    final value = label['value'];

    return DSRequestLocationBubble(
      label: 'Send location',
      replyContent: replyContent,
      type: type,
      value: value,
      align: align,
      borderRadius: borderRadius,
      style: style,
      showRequestLocationButton: showRequestLocationButton,
      simpleStyle: simpleStyle,
    );
  }
}
