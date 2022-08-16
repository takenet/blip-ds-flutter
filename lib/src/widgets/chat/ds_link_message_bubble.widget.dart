import 'package:any_link_preview/any_link_preview.dart';
import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSLinkMessageBubble extends StatelessWidget {
  final DSAlign align;

  const DSLinkMessageBubble({
    required this.align,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = align == DSAlign.right
        ? DSColors.neutralLightSnow
        : DSColors.neutralDarkCity;

    return DSMessageBubble(
      align: align,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnyLinkPreview(
            link: 'https://www.take.net/',
            boxShadow: const [],
            backgroundColor: Colors.transparent,
            titleStyle: DSBodyTextStyle(
              color: color,
            ),
            bodyStyle: DSCaptionSmallTextStyle(
              color: color,
            ),
            bodyMaxLines: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              left: 14.0,
              right: 14.0,
            ),
            child: DSCaptionText(
              text: 'https://www.take.net/',
              color: align == DSAlign.right
                  ? DSColors.primaryLight
                  : DSColors.primaryNight,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
