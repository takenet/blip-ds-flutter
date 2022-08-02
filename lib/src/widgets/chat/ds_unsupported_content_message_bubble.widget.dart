import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSUnsupportedContentMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget? leftWidget;
  final String? text;

  const DSUnsupportedContentMessageBubble(
      {Key? key, required this.align, this.leftWidget, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leftWidget ??
              Icon(
                Icons.block,
                color: align == DSAlign.left
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
                size: 18.0,
              ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DSBodyText(
              text: text ?? 'Unsupported content',
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
