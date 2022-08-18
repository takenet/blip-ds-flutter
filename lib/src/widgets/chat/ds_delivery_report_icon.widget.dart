import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A Design System widget used to display a delivery report status icon.
class DSDeliveryReportIcon extends StatelessWidget {
  final DSDeliveryReportStatus deliveryStatus;

  /// Creates a new Design System's [DSDeliveryReportIcon]
  const DSDeliveryReportIcon({
    Key? key,
    required this.deliveryStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buidIcon();
  }

  Widget _buidIcon() {
    const String path = 'assets/images';

    switch (deliveryStatus) {
      case DSDeliveryReportStatus.accepted:
        return _getIcon(
          '$path/check.svg',
          DSColors.neutralMediumElephant,
        );

      case DSDeliveryReportStatus.received:
        return _getIcon(
          '$path/check_double.svg',
          DSColors.neutralMediumElephant,
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
        return DSCaptionSmallText(
          text: 'Falha ao enviar mensagem',
          color: DSColors.extendRedsDragon,
        );
    }
  }

  Widget _getIcon(final String path, final Color color) {
    return SvgPicture.asset(
      path,
      color: color,
      package: DSUtils.packageName,
      height: 10.0,
    );
  }
}
