import 'package:flutter/material.dart';
import 'package:blip_ds/blip_ds.dart';

import '../../enums/ds_survey_scale.enum.dart';
import '../../enums/ds_survey_type.enum.dart';

class DSSurveyCard extends StatelessWidget {
  final DSAlign align;
  final Widget? leftWidget;
  final String? text;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final DSSurveyType type;
  final DSSurveyScale scale;

  DSSurveyCard({
    Key? key,
    DSMessageBubbleStyle? style,
    required this.align,
    this.leftWidget,
    this.text,
    this.borderRadius = const [DSBorderRadius.all],
    this.type = DSSurveyType.recomendation,
    this.scale = DSSurveyScale.numeric5,
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
            _getTitlePreview(),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DSCaptionText(
                _getDescriptionPreview(false),
              ),
              DSCaptionText(
                _getDescriptionPreview(true),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          _containerButton(),
        ],
      ),
    );
  }

  Widget _containerButton() {
    final totalNumbers = int.parse(
      scale.name.replaceAll(RegExp(r'[^\d]'), ''),
    );
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 1; i <= totalNumbers; i++)
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(width: 1.0, color: DSColors.neutralMediumCloud),
              ),
              child: [
                DSSurveyScale.star3,
                DSSurveyScale.star5,
              ].contains(scale)
                  ? const Icon(
                      DSIcons.favorite_solid,
                      color: DSColors.neutralDarkCity,
                    )
                  : Center(
                      child: DSButtonText(
                        '$i',
                        color: DSColors.neutralDarkCity,
                      ),
                    ),
            ),
        ],
      ),
    );
  }

  _getTitlePreview() {
    switch (type) {
      case DSSurveyType.recomendation:
        return 'Would you recommend our Chatbot?';
      case DSSurveyType.solution:
        return 'How did you feel about the service on this channel?';
      case DSSurveyType.chatbot:
        return 'How did you feel about the chatbot assistance?';
      default:
        return 'How did you feel about the service on this channel?';
    }
  }

  _getDescriptionPreview(bool positiveLabel) {
    if (positiveLabel == true) {
      return type == DSSurveyType.recomendation ? 'Recommend' : 'Positive';
    } else {
      return type == DSSurveyType.recomendation
          ? "Don't Recommend"
          : 'Negative';
    }
  }

  // changeScale: function () {
  //   this.isStarIcon = this.scale.includes(STAR)
  //   this.isScoredActivated = false
  //   this.numberOfIcons = parseInt(
  //     this.scale.indexOf(NUMERIC) !== -1
  //       ? this.scale.split(NUMERIC)[1]
  //       : this.scale.split(STAR)[1]
  //   )
  // },
}
