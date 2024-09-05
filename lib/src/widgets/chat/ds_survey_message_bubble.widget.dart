import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../enums/ds_survey_scale.enum.dart';
import '../../enums/ds_survey_type.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../texts/ds_button_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import '../texts/ds_headline_small_text.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSSurveyMessageBubble extends StatelessWidget {
  final DSAlign align;
  final Widget? leftWidget;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final DSSurveyType type;
  final DSSurveyScale scale;

  //TODO: there are fields named 'question' and 'score' in desk web that were not used here

  DSSurveyMessageBubble({
    super.key,
    DSMessageBubbleStyle? style,
    required this.align,
    this.leftWidget,
    this.borderRadius = const [DSBorderRadius.all],
    this.type = DSSurveyType.recommendation,
    this.scale = DSSurveyScale.numeric5,
  }) : style = style ?? DSMessageBubbleStyle();

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
              Flexible(
                child: DSCaptionText(
                  _getDescriptionPreview(false),
                ),
              ),
              Flexible(
                child: DSCaptionText(
                  _getDescriptionPreview(true),
                ),
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
      case DSSurveyType.recommendation:
        return "survey.recommendation".translate();
      case DSSurveyType.solution:
        return 'survey.solution'.translate();
      case DSSurveyType.chatbot:
        return 'survey.chatbot'.translate();
    }
  }

  String _getDescriptionPreview(bool positiveLabel) => positiveLabel
      ? type == DSSurveyType.recommendation
          ? 'survey.recommendation-answered-positive'.translate()
          : 'survey.positive'.translate()
      : type == DSSurveyType.recommendation
          ? "survey.recommendation-answered-negative".translate()
          : 'survey.negative'.translate();
}
