import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../enums/ds_align.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../animations/ds_spinner_loading.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSLocationMessageBubble extends StatelessWidget {
  final DSAlign align;
  final DSMessageBubbleStyle style;
  final String? title;
  final double latitude;
  final double longitude;

  DSLocationMessageBubble({
    super.key,
    required this.align,
    required this.latitude,
    required this.longitude,
    DSMessageBubbleStyle? style,
    this.title,
  }) : style = style ?? DSMessageBubbleStyle();

  /// TODO: Use another method do get this tokey, e.g: firebase remote config.
  final appKey = 'AIzaSyAlC3a3DZZBscR0QIbQpee13Op9Y05m_wc';

  @override
  Widget build(BuildContext context) {
    final foregroundColor = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return GestureDetector(
      onTap: () async {
        final availableMaps = await MapLauncher.installedMaps;

        await availableMaps.first.showMarker(
          coords: Coords(latitude, longitude),
          title: "Ocean Beach",
        );
      },
      child: DSMessageBubble(
        shouldUseDefaultSize: true,
        defaultMaxSize: 240.0,
        defaultMinSize: 240.0,
        padding: EdgeInsets.zero,
        align: align,
        style: style,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DSCachedNetworkImageView(
              url:
                  'https://maps.googleapis.com/maps/api/staticmap?&size=360x360&markers=$latitude,$longitude&key=$appKey',
              placeholder: (_, __) => _buildLoading(),
              align: align,
              style: style,
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
