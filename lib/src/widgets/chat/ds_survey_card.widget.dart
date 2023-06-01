import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSSurveyCard extends StatelessWidget {
  final DSAlign align;
  final Widget? leftWidget;
  final String? text;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final String? title;
  final String? lowScore;
  final String? highScore;

  DSSurveyCard({
    Key? key,
    required this.align,
    this.leftWidget,
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
    this.title,
    this.lowScore,
    this.highScore,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      borderRadius: borderRadius,
      align: align,
      style: style,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DSHeadlineSmallText(
            title ?? 'Would you recommend our chatbot?',
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DSCaptionText(lowScore ?? "Don't Recommend"),
              DSCaptionText(highScore ?? 'Recommend'),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _containerButton('1'),
              _containerButton('2'),
              _containerButton('3'),
              _containerButton('4'),
              _containerButton('5'),
            ],
          )
        ],
      ),
    );
  }

  Container _containerButton(String number) {
    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.0, color: DSColors.neutralMediumCloud),
      ),
      child: Center(
        child: DSButtonText(number, color: DSColors.neutralDarkCity),
      ),
    );
  }
}
