import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../extensions/ds_localization.extension.dart';
import '../../../models/ds_media_link.model.dart';
import '../../../models/ds_media_reply_content_props.model.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../services/ds_file.service.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../animations/ds_spinner_loading.widget.dart';
import '../../chat/reply/ds_in_reply_content.widget.dart';
import '../../texts/ds_body_text.widget.dart';
import '../../texts/ds_caption_text.widget.dart';
import '../ds_audio_duration_view.widget.dart';
import '../ds_cached_network_image_view.widget.dart';
import '../ds_cached_video_thumbnail_view.widget.dart';
import '../ds_file_extension_icon.util.dart';

class DSMediaReplyContent extends StatelessWidget {
  DSMediaReplyContent({
    super.key,
    required this.media,
    required this.align,
    required this.shouldAuthenticate,
    this.isPreview = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSMediaLink media;
  final DSAlign align;
  final bool shouldAuthenticate;
  final bool isPreview;
  final DSMessageBubbleStyle style;

  late final _foregroundColor = style.isLightBubbleBackground(align)
      ? const Color.fromARGB(255, 39, 4, 4)
      : DSColors.surface1;

  @override
  Widget build(BuildContext context) {
    final props = _buildReplyContent();

    return DSInReplyContent(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(
          props.mediaIcon,
          color: _foregroundColor,
          size: isPreview ? 18.0 : 24.0,
        ),
      ),
      trailing: props.trailing,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isPreview
              ? DSCaptionText(
                  props.title,
                  color: _foregroundColor,
                  height: 1.0,
                )
              : DSBodyText(
                  props.title,
                  color: _foregroundColor,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  height: 1.0,
                ),
          if (props.subtitle != null) props.subtitle!,
        ],
      ),
    );
  }

  DSMediaReplyContentProps _buildReplyContent() {
    bool containsType(String type) => media.type.contains(type);

    late final String mediaTextTranslateKey;
    late final DSMediaReplyContentProps props;

    if (containsType('audio')) {
      mediaTextTranslateKey = 'media.audio.text';
      props = _buildAudioContent();
    } else if (containsType('video')) {
      mediaTextTranslateKey = 'media.video.text';
      props = _buildVideoContent();
    } else if (containsType('image')) {
      mediaTextTranslateKey = 'media.image.text';
      props = _buildImageContent();
    } else {
      mediaTextTranslateKey = 'media.document.text';
      props = _buildDocumentContent();
    }

    final mediaText = (media.text?.isNotEmpty ?? false)
        ? media.text
        : mediaTextTranslateKey.translate();

    props.title = mediaText;

    return props;
  }

  DSMediaReplyContentProps _buildAudioContent() {
    final mediaTextTranslateKey = 'media.audio.text';
    final mediaIcon = DSIcons.audio_outline;
    final subtitle = DSAudioDurationView(
      media: media,
      foreground: _foregroundColor,
    );

    return DSMediaReplyContentProps(
      mediaTextTranslateKey: mediaTextTranslateKey,
      mediaIcon: mediaIcon,
      subtitle: subtitle,
    );
  }

  DSMediaReplyContentProps _buildVideoContent() {
    final size = isPreview ? 50.0 : 70.0;
    final mediaTextTranslateKey = 'media.video.text';
    final mediaIcon = DSIcons.video_outline;
    final trailing = _buildRoundedMedia(
      DSCachedVideoThumbnailView(
        url: media.uri,
        width: size,
        height: size,
        fit: BoxFit.cover,
        shouldAuthenticate: shouldAuthenticate,
        style: style,
        align: align,
        mediaSize: media.size ?? 0,
        type: media.type,
        placeholder: _buildLoadingPlaceholder,
      ),
    );

    return DSMediaReplyContentProps(
      mediaTextTranslateKey: mediaTextTranslateKey,
      mediaIcon: mediaIcon,
      trailing: trailing,
      size: size,
    );
  }

  DSMediaReplyContentProps _buildImageContent() {
    final size = isPreview ? 50.0 : 65.0;
    final mediaTextTranslateKey = 'media.image.text';
    final mediaIcon = DSIcons.file_image_outline;

    final trailing = _buildRoundedMedia(
      DSCachedNetworkImageView(
        fit: BoxFit.cover,
        width: size,
        height: size,
        url: media.uri,
        align: align,
        style: style,
        shouldAuthenticate: shouldAuthenticate,
        placeholder: _buildLoadingPlaceholder,
      ),
    );

    return DSMediaReplyContentProps(
      mediaTextTranslateKey: mediaTextTranslateKey,
      mediaIcon: mediaIcon,
      trailing: trailing,
      size: size,
    );
  }

  DSMediaReplyContentProps _buildDocumentContent() {
    final size = isPreview ? 35.0 : 40.0;
    final mediaTextTranslateKey = 'media.document.text';
    final mediaIcon = DSIcons.file_empty_file_outline;

    final trailing = Padding(
      padding: const EdgeInsets.all(4.0),
      child: DSFileExtensionIcon(
        filename: media.title ??
            '${media.uri.hashCode}.${DSFileService.getExtensionFromMimeType(media.type)}',
        size: size,
      ),
    );

    return DSMediaReplyContentProps(
      mediaTextTranslateKey: mediaTextTranslateKey,
      mediaIcon: mediaIcon,
      trailing: trailing,
      size: size,
    );
  }

  Widget _buildRoundedMedia(Widget child) {
    if (isPreview) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          4.0,
        ),
        child: child,
      );
    }

    return child;
  }

  Widget _buildLoadingPlaceholder(BuildContext _, String __) => Center(
        child: DSSpinnerLoading(
          color: style.isLightBubbleBackground(align)
              ? DSColors.primaryNight
              : DSColors.neutralLightSnow,
          size: 20.0,
          lineWidth: 2.0,
        ),
      );
}
