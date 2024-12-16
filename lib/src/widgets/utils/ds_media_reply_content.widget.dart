import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../enums/ds_align.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_media_link.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../services/ds_file.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../animations/ds_spinner_loading.widget.dart';
import '../chat/reply/ds_in_reply_content.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_small_text.widget.dart';
import 'ds_cached_network_image_view.widget.dart';
import 'ds_cached_video_thumbnail_view.widget.dart';
import 'ds_file_extension_icon.util.dart';

class DSMediaReplyContent extends StatefulWidget {
  DSMediaReplyContent({
    super.key,
    required this.media,
    required this.align,
    required this.foreground,
    required this.shouldAuthenticate,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSMediaLink media;
  final DSAlign align;
  final Color foreground;
  final DSMessageBubbleStyle style;
  final bool shouldAuthenticate;

  @override
  createState() => _DSMediaReplyContentState();
}

class _DSMediaReplyContentState extends State<DSMediaReplyContent> {
  final audioPlayer = AudioPlayer();

  late final mediaLink = widget.media;
  late final align = widget.align;
  late final foreground = widget.foreground;
  late final style = widget.style;
  late final shouldAuthenticate = widget.shouldAuthenticate;

  late final String mediaTextTranslateKey;
  late final IconData mediaIcon;
  late final Widget? trailing;

  final subtitle = ValueNotifier('');

  @override
  initState() {
    super.initState();

    bool containsType(String type) => mediaLink.type.contains(type);

    if (containsType('audio')) {
      _buildAudioContent();
    } else if (containsType('video')) {
      _buildVideoContent();
    } else if (containsType('image')) {
      _buildImageContent();
    } else {
      _buildDocumentContent();
    }
  }

  @override
  dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void _buildAudioContent() {
    mediaTextTranslateKey = 'media.audio.text';
    mediaIcon = DSIcons.audio_outline;

    trailing = const SizedBox.shrink();

    _loadAudioDuration();
  }

  Future<void> _loadAudioDuration() async {
    try {
      await audioPlayer.setUrl(mediaLink.previewUri ?? mediaLink.uri);

      final duration = audioPlayer.duration;
      subtitle.value = RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
              .firstMatch("$duration")
              ?.group(1) ??
          "$duration";
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }

  void _buildVideoContent() {
    mediaTextTranslateKey = 'media.video.text';
    mediaIcon = DSIcons.video_outline;

    trailing = DSCachedVideoThumbnailView(
      url: mediaLink.uri,
      width: 70.0,
      height: 70.0,
      fit: BoxFit.cover,
      shouldAuthenticate: shouldAuthenticate,
      style: style,
      align: align,
      mediaSize: mediaLink.size!,
      type: mediaLink.type,
      placeholder: _buildLoadingPlaceholder,
    );
  }

  void _buildImageContent() {
    mediaTextTranslateKey = 'media.image.text';
    mediaIcon = DSIcons.file_image_outline;

    trailing = DSCachedNetworkImageView(
      fit: BoxFit.cover,
      width: 65.0,
      height: 65.0,
      url: mediaLink.uri,
      align: align,
      style: style,
      shouldAuthenticate: shouldAuthenticate,
      placeholder: _buildLoadingPlaceholder,
    );
  }

  void _buildDocumentContent() {
    mediaTextTranslateKey = 'media.document.text';
    mediaIcon = DSIcons.file_empty_file_outline;

    trailing = Padding(
      padding: const EdgeInsets.all(4.0),
      child: DSFileExtensionIcon(
        filename: mediaLink.title ??
            '${mediaLink.uri.hashCode}.${DSFileService.getExtensionFromMimeType(mediaLink.type)}',
        size: 40.0,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return DSInReplyContent(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(
          mediaIcon,
          color: foreground,
          size: 24.0,
        ),
      ),
      trailing: trailing,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSBodyText(
            (mediaLink.text?.isNotEmpty ?? false)
                ? mediaLink.text
                : mediaTextTranslateKey.translate(),
            color: foreground,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            height: 1.0,
          ),
          ValueListenableBuilder<String>(
            valueListenable: subtitle,
            builder: (_, value, __) => value.isNotEmpty
                ? DSCaptionSmallText(
                    value,
                    color: foreground,
                    height: 1.0,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
