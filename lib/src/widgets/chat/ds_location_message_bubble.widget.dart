import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../services/ds_auth.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_utils.util.dart';
import '../animations/ds_spinner_loading.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_headline_large_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSLocationMessageBubble extends StatelessWidget {
  final DSAlign align;
  final DSMessageBubbleStyle style;
  final String? title;
  final DSReplyContent? replyContent;
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
    List<AvailableMap>? availableMaps;

    void initMaps() async {
      availableMaps = await MapLauncher.installedMaps;
    }

    initMaps();

    void openMapList() {
      if (availableMaps!.isNotEmpty && hasValidCoordinates) {
        showModalBottomSheet(
            showDragHandle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  30.0,
                ),
              ),
            ),
            context: context,
            builder: (context) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DSHeadlineLargeText(
                              "Selecione uma ação",
                              fontWeight: FontWeight.bold,
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2.0,
                      ),
                      for (var map in availableMaps!)
                        ListTile(
                          onTap: () {
                            map.showMarker(
                              coords: Coords(lat, long),
                              title: title ?? '',
                            );
                            Navigator.pop(context);
                          },
                          title: DSBodyText("Abrir com ${map.mapName}"),
                        ),
                    ],
                  ),
                ),
              );
            });
      } else {
        print("Aplicativo não instalado!");
      }
    }

    return GestureDetector(
      onTap: () => openMapList(),
      child: DSMessageBubble(
        shouldUseDefaultSize: true,
        defaultMaxSize: DSUtils.bubbleMinSize,
        defaultMinSize: DSUtils.bubbleMinSize,
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
