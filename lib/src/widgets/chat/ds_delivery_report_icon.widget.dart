import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../enums/ds_delivery_report_status.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/enums/ds_theme_type.enum.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_utils.util.dart';
import '../texts/ds_caption_small_text.widget.dart';

/// A Design System widget used to display a delivery report status icon.
class DSDeliveryReportIcon extends StatelessWidget {
  final DSDeliveryReportStatus deliveryStatus;
  final DSThemeType theme;

  /// Creates a new Design System's [DSDeliveryReportIcon]
  const DSDeliveryReportIcon({
    super.key,
    required this.deliveryStatus,
    this.theme = DSThemeType.dark,
  });

  @override
  Widget build(BuildContext context) {
    return _buidIcon();
  }

  Widget _buidIcon() {
    const String path = 'assets/images';

    switch (deliveryStatus) {
      case DSDeliveryReportStatus.dispatched:
      case DSDeliveryReportStatus.accepted:
        return _getIcon(
          '$path/check.svg',
          theme == DSThemeType.dark
              ? DSColors.neutralMediumElephant
              : DSColors.neutralLightSnow,
        );

      case DSDeliveryReportStatus.failed:
        return DSCaptionSmallText(
          'delivery.send-fail'.translate(),
          color: DSColors.actionColorNegative,
        );

      case DSDeliveryReportStatus.sending:
        return Icon(
          DSIcons.clock_outline,
          size: 16,
          color: theme == DSThemeType.dark
              ? DSColors.contentDefault
              : DSColors.neutralLightSnow,
        );

      case DSDeliveryReportStatus.received:
        return _getIcon(
          '$path/check_double.svg',
          theme == DSThemeType.dark
              ? DSColors.neutralMediumElephant
              : DSColors.neutralLightSnow,
        );

      case DSDeliveryReportStatus.consumed:
        return Container(
          width: 30.0,
          height: 15.0,
          decoration: const BoxDecoration(
            color: DSColors.neutralMediumElephant,
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getIcon(
                '$path/check_double.svg',
                DSColors.neutralLightSnow,
              ),
            ],
          ),
        );

      default:
        return Icon(
          DSIcons.clock_outline,
          size: 16,
          color: theme == DSThemeType.dark
              ? DSColors.contentDefault
              : DSColors.neutralLightSnow,
        );
    }
  }

  Widget _getIcon(final String path, final Color color) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
      package: DSUtils.packageName,
      height: 10.0,
    );
  }
}
