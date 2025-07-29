import 'package:flutter/material.dart';

import '../../../../blip_ds.dart';
import '../../../extensions/ds_localization.extension.dart';

class DSInteractiveRequestCallMessageBubble extends StatelessWidget {
  final DSInteractiveMessage content;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  late final bool _isLightBubbleBackground;
  late final Color _foregroundColor;

  DSInteractiveRequestCallMessageBubble({
    super.key,
    required this.content,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle() {
    _initProperties();
  }

  void _initProperties() {
    _isLightBubbleBackground = style.isLightBubbleBackground(align);

    _foregroundColor = _isLightBubbleBackground
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      style: style,
      borderRadius: borderRadius,
      child: Column(
        spacing: 8.0,
        children: [
          DSBodyText(
            'calls.permission-request.body-title'.translate(),
            overflow: TextOverflow.visible,
            color: _foregroundColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.0,
            children: [
              Icon(
                DSIcons.voip_calling_outline,
                size: 20.0,
                color: _foregroundColor,
              ),
              Flexible(
                child: DSCaptionText(
                  'calls.permission-request.body-text'.translate(),
                  overflow: TextOverflow.visible,
                  color: _foregroundColor,
                ),
              ),
            ],
          ),
          Column(
            children: [
              DSDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DSBodyText(
                    'calls.permission-request.left-action-label'.translate(),
                    color: _foregroundColor,
                  ),
                  DSRadio(
                    value: 'value',
                    onChanged: (value) {},
                    groupValue: 'groupValue',
                  ),
                  DSBodyText(
                    'calls.permission-request.right-action-label'.translate(),
                    color: _foregroundColor,
                  ),
                  DSRadio(
                    value: 'value2',
                    onChanged: (value) {},
                    groupValue: 'groupValue',
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
