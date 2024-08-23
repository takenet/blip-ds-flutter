import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../services/ds_auth.service.dart';
import '../../services/ds_bottom_sheet.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_utils.util.dart';
import '../animations/ds_spinner_loading.widget.dart';
import '../buttons/ds_icon_button.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_headline_large_text.widget.dart';
import '../utils/ds_cached_network_image_view.widget.dart';
import '../utils/ds_divider.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSLocationMessageBubble extends StatefulWidget {
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
  State<DSLocationMessageBubble> createState() =>
      _DSLocationMessageBubbleState();
}

class _DSLocationMessageBubbleState extends State<DSLocationMessageBubble> {
  late final Future<List<AvailableMap>> _installedMaps;
  late final bool _hasValidCoordinates;
  late final Color _foregroundColor;
  late final double? _doubleLatitude;
  late final double? _doubleLongitude;

  @override
  void initState() {
    super.initState();

    _foregroundColor = widget.style.isLightBubbleBackground(widget.align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    _doubleLatitude = double.tryParse(widget.latitude);
    _doubleLongitude = double.tryParse(widget.longitude);

    _hasValidCoordinates = _doubleLatitude != null && _doubleLongitude != null;

    _installedMaps = MapLauncher.installedMaps;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _hasValidCoordinates ? _openMapList : null,
        child: DSMessageBubble(
          shouldUseDefaultSize: true,
          defaultMaxSize: DSUtils.bubbleMinSize,
          defaultMinSize: DSUtils.bubbleMinSize,
          borderRadius: widget.borderRadius,
          replyContent: widget.replyContent,
          padding: EdgeInsets.zero,
          align: widget.align,
          style: widget.style,
          child: _buildBody(),
        ),
      );

  Widget _buildBody() => Padding(
        padding: widget.replyContent == null
            ? EdgeInsets.zero
            : const EdgeInsets.only(top: 8.0),
        child: Center(
          child: Column(
            children: [
              _hasValidCoordinates
                  ? _buildThumbnail()
                  : _buildBrokenThumbnail(),
              if (widget.title?.isNotEmpty ?? false) _buildTitle(),
            ],
          ),
        ),
      );

  Widget _buildTitle() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: DSBodyText(
            widget.title!,
            color: _foregroundColor,
            isSelectable: true,
            overflow: TextOverflow.visible,
          ),
        ),
      );

  Widget _buildThumbnail() => DSCachedNetworkImageView(
        url:
            'https://maps.googleapis.com/maps/api/staticmap?&size=360x360&markers=${widget.latitude},${widget.longitude}&key=${DSAuthService.googleKey}',
        placeholder: (_, __) => _buildLoading(),
        align: widget.align,
        style: widget.style,
      );

  Widget _buildBrokenThumbnail() => SizedBox(
        width: 240,
        height: 240,
        child: Icon(
          DSIcons.file_image_broken_outline,
          size: 80,
          color: widget.style.isLightBubbleBackground(widget.align)
              ? DSColors.neutralMediumElephant
              : DSColors.neutralMediumCloud,
        ),
      );

  void _openMapList() {
    DSBottomSheetService(
      context: context,
      fixedHeader: _buildBottomSheetHeader(),
      builder: (_) => _buildBottomSheetBody(),
    ).show();
  }

  Widget _buildBottomSheetHeader() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            top: false,
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DSHeadlineLargeText(
                  'message.select-action'.translate(),
                ),
                DSIconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(DSIcons.close_outline,
                      color: DSColors.neutralDarkRooftop),
                ),
              ],
            ),
          ),
        ),
        const DSDivider()
      ],
    );
  }

  Widget _buildBottomSheetBody() {
    return SafeArea(
      child: FutureBuilder(
        future: _installedMaps,
        builder: (_, snapshot) => snapshot.hasData && snapshot.data!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final map = snapshot.data![index];

                  return ListTile(
                    onTap: () {
                      map.showMarker(
                        coords: Coords(
                          _doubleLatitude!,
                          _doubleLongitude!,
                        ),
                        title: widget.title ?? '',
                      );

                      Get.back();
                    },
                    title: DSBodyText(
                      "message.open-with".translate() + " ${map.mapName}",
                    ),
                  );
                },
              )
            : _buildLoading(),
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
}
