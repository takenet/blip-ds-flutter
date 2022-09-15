import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSUnsupportedContentMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget? leftWidget;
  final String? text;
  final List<DSBorderRadius> borderRadius;

  const DSUnsupportedContentMessageBubble({
    Key? key,
    required this.align,
    this.leftWidget,
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      borderRadius: borderRadius,
      align: align,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leftWidget ??
              Image.asset(
                align == DSAlign.left
                    ? 'assets/images/block_neutral_dark_city.png'
                    : 'assets/images/block_neutral_light_snow.png',
                package: DSUtils.packageName,
                width: 20.0,
              ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DSBodyText(
              text ?? 'Unsupported content',
              color: align == DSAlign.left
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
            ),
          ),
        ],
      ),
    );
  }
}
