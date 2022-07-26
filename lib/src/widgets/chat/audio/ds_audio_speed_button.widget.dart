import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSAudioSpeedButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Color borderColor;
  final Color color;
  final String text;

  const DSAudioSpeedButtonWidget(
      {Key? key,
      required this.onTap,
      required this.color,
      required this.borderColor,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: 10,
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(color: borderColor),
          ),
          child: Align(
            alignment: Alignment.center,
            child: DSCaptionText(
              text: text,
              color: color,
              fontWeight: DSFontWeights.bold,
            ),
          ),
        ),
      ),
    );
  }
}
