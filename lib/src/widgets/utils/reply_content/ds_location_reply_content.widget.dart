import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../models/ds_location.model.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../services/ds_auth.service.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../animations/ds_spinner_loading.widget.dart';
import '../../chat/reply/ds_in_reply_content.widget.dart';
import '../../texts/ds_body_text.widget.dart';
import '../../texts/ds_caption_text.widget.dart';
import '../ds_cached_network_image_view.widget.dart';

class DSLocationReplyContent extends StatelessWidget {
  DSLocationReplyContent({
    super.key,
    required this.location,
    required this.align,
    this.simpleStyle = false,
    this.isPreview = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSLocation location;
  final DSAlign align;
  final bool simpleStyle;
  final bool isPreview;
  final DSMessageBubbleStyle style;

  bool get hasValidCoordinates =>
      location.latitude != null && location.longitude != null;

  double get size => isPreview ? 50.0 : 65.0;

  Color get foregroundColor => style.isLightBubbleBackground(align)
      ? const Color.fromARGB(255, 39, 4, 4)
      : DSColors.surface1;

  Widget _buildThumbnail() => DSCachedNetworkImageView(
        width: size,
        height: size,
        url:
            'https://maps.googleapis.com/maps/api/staticmap?&size=360x360&markers=${location.latitude},${location.longitude}&key=${DSAuthService.googleKey}',
        placeholder: (_, __) => _buildLoading(),
        align: align,
        style: style,
      );

  Widget _buildBrokenThumbnail() => SizedBox(
        width: size,
        height: size,
        child: Icon(
          DSIcons.file_image_broken_outline,
          size: 80,
          color: style.isLightBubbleBackground(align)
              ? DSColors.neutralMediumElephant
              : DSColors.neutralMediumCloud,
        ),
      );

  Widget _buildLoading() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Center(
              child: DSSpinnerLoading(
                color: style.isLightBubbleBackground(align)
                    ? DSColors.primaryNight
                    : DSColors.neutralLightSnow,
                size: isPreview ? 26.0 : 32.0,
                lineWidth: isPreview ? 2.0 : 4.0,
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DSInReplyContent(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(
          DSIcons.localization_outline,
          color: foregroundColor,
          size: isPreview ? 18.0 : 24.0,
        ),
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(
          4.0,
        ),
        child:
            hasValidCoordinates ? _buildThumbnail() : _buildBrokenThumbnail(),
      ),
      child: isPreview
          ? DSCaptionText(
              location.text,
              color: foregroundColor,
            )
          : DSBodyText(
              location.text,
              color: foregroundColor,
              maxLines: 2,
            ),
    );
  }
}
