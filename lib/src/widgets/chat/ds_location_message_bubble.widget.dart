import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DSLocationMessageBubble extends StatelessWidget {
  final DSAlign align;
  final DSMessageBubbleStyle style;
  final String? title;
  final String latitude;
  final String longitude;

  DSLocationMessageBubble({
    super.key,
    required this.align,
    required this.latitude,
    required this.longitude,
    DSMessageBubbleStyle? style,
    this.title,
  }) : style = style ?? DSMessageBubbleStyle();

  final appKey = 'AIzaSyAlC3a3DZZBscR0QIbQpee13Op9Y05m_wc';

  @override
  Widget build(BuildContext context) {
    final foregroundColor = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return GestureDetector(
      onTap: () => launchUrl(
        Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
        ),
      ),
      child: DSMessageBubble(
        shouldUseDefaultSize: true,
        defaultMaxSize: 400.0,
        defaultMinSize: 400.0,
        padding: EdgeInsets.zero,
        align: align,
        style: style,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DSCachedNetworkImageView(
              url:
                  'https://maps.googleapis.com/maps/api/staticmap?&size=400x300&markers=$latitude,$longitude&key=$appKey',
              placeholder: (_, __) => _buildLoading(),
              align: align,
              style: style,
              height: 240.0,
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
