import 'package:flutter/material.dart';

import '../../../themes/texts/utils/ds_font_weights.theme.dart';
import '../../texts/ds_caption_text.widget.dart';

class DSAudioSpeedButton extends InkWell {
  final Color borderColor;
  final Color color;
  final String text;

  DSAudioSpeedButton({
    super.key,
    required super.onTap,
    required this.color,
    required this.borderColor,
    required this.text,
  }) : super(
          child: Container(
            width: 44.0,
            height: 46.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Center(
              child: DSCaptionText(
                text,
                color: color,
                fontWeight: DSFontWeights.bold,
              ),
            ),
          ),
        );
}
