import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../services/ds_auth.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../animations/ds_spinner_loading.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSLocationMessageBubble extends StatelessWidget {
  final DSAlign align;
  final DSMessageBubbleStyle style;
  final String? title;
  final dynamic replyContent;
  final String latitude;
  final String longitude;
  final List<DSBorderRadius> borderRadius;

  DSLocationMessageBubble({
    super.key,
    required this.align,
    required this.latitude,
    required this.longitude,
    this.replyContent,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
    this.title,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    final foregroundColor = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    final lat = double.tryParse(latitude);
    final long = double.tryParse(longitude);

    final hasValidCoordinates = lat != null && long != null;
    return GestureDetector(
      onTap: () async {
        final availableMaps = await MapLauncher.installedMaps;

        if (hasValidCoordinates) {
          await availableMaps.first.showMarker(
            coords: Coords(lat, long),
            title: title ?? '',
          );
        }
      },
      child: DSMessageBubble(
        shouldUseDefaultSize: true,
        defaultMaxSize: 240.0,
        defaultMinSize: 240.0,
        borderRadius: borderRadius,
        replyContent: replyContent,
        padding: EdgeInsets.zero,
        align: align,
        style: style,
        child: Padding(
          padding: replyContent == null
              ? EdgeInsets.zero
              : const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hasValidCoordinates
                  ? DSCachedNetworkImageView(
                      url:
                          'https://maps.googleapis.com/maps/api/staticmap?&size=360x360&markers=$latitude,$longitude&key=${DSAuthService.googleKey}',
                      placeholder: (_, __) => _buildLoading(),
                      align: align,
                      style: style,
                    )
                  : SizedBox(
                      width: 240,
                      height: 240,
                      child: Icon(
                        DSIcons.file_image_broken_outline,
                        size: 80,
                        color: style.isLightBubbleBackground(align)
                            ? DSColors.neutralMediumElephant
                            : DSColors.neutralMediumCloud,
                      ),
                    ),
              if (title?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: DSBodyText(
                      title!,
                      color: foregroundColor,
                      isSelectable: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

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
                size: 32.0,
                lineWidth: 4.0,
              ),
            ),
          ),
        ],
      );
}
