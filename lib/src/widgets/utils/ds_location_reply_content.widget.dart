import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../models/ds_location.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../services/ds_auth.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../animations/ds_spinner_loading.widget.dart';
import '../chat/reply/ds_in_reply_content.widget.dart';
import '../texts/ds_body_text.widget.dart';
import 'ds_cached_network_image_view.widget.dart';

class DSLocationReplyContent extends StatefulWidget {
  DSLocationReplyContent({
    super.key,
    required this.location,
    required this.align,
    required this.foreground,
    this.simpleStyle = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSLocation location;
  final DSAlign align;
  final Color foreground;
  final bool simpleStyle;
  final DSMessageBubbleStyle style;

  @override
  State<DSLocationReplyContent> createState() => _DSLocationReplyContentState();
}

class _DSLocationReplyContentState extends State<DSLocationReplyContent> {
  late final DSLocation _location = widget.location;
  late final bool _hasValidCoordinates;

  @override
  void initState() {
    super.initState();

    _hasValidCoordinates =
        _location.latitude != null && _location.longitude != null;
  }

  Widget _buildThumbnail() => DSCachedNetworkImageView(
        width: 65,
        height: 65,
        url:
            'https://maps.googleapis.com/maps/api/staticmap?&size=360x360&markers=${_location.latitude},${_location.longitude}&key=${DSAuthService.googleKey}',
        placeholder: (_, __) => _buildLoading(),
        align: widget.align,
        style: widget.style,
      );

  Widget _buildBrokenThumbnail() => SizedBox(
        width: 65,
        height: 65,
        child: Icon(
          DSIcons.file_image_broken_outline,
          size: 80,
          color: widget.style.isLightBubbleBackground(widget.align)
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
                color: widget.style.isLightBubbleBackground(widget.align)
                    ? DSColors.primaryNight
                    : DSColors.neutralLightSnow,
                size: 32.0,
                lineWidth: 4.0,
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
          color: widget.foreground,
        ),
      ),
      trailing:
          _hasValidCoordinates ? _buildThumbnail() : _buildBrokenThumbnail(),
      child: DSBodyText(
        widget.location.text,
        color: widget.foreground,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
