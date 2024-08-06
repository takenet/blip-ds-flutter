import 'package:flutter/material.dart';

import '../../../blip_ds.dart';

class DSEndRecord extends StatelessWidget {
  final Uri uri;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final String? uniqueId;
  final bool shouldAuthenticate;
  final DSReplyContent? replyContent;

  DSEndRecord({
    super.key,
    required this.uri,
    required this.align,
    this.uniqueId,
    this.replyContent,
    this.borderRadius = const [DSBorderRadius.all],
    this.shouldAuthenticate = false,
    final DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    final isDefaultBubbleColors = style.isDefaultBubbleBackground(align);
    final isLightBubbleBackground = style.isLightBubbleBackground(align);

    return DSMessageBubble(
      borderRadius: borderRadius,
      align: align,
      replyContent: replyContent,
      style: style,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: DSColors.success,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    DSIcons.voip_calling_outline,
                    color: DSColors.contentDefault,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    DSHeadlineSmallText(
                      "Ligação",
                    ),
                    DSBodyText(
                      "Finalizada",
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                DSBodyText("+55 31 999999999"),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: DSMessageBubble(
                align: align,
                style: style,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DSBodyText("Carregar gravação"),
                    Container(
                      decoration: BoxDecoration(
                        color: DSColors.contentDefault,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          DSIcons.refresh_outline,
                          color: DSColors.neutralLightSnow,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
