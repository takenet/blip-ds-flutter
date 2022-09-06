import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSUserAvatar extends StatelessWidget {
  final String text;
  final double radius;
  final Color backgroundColor;
  final Color textColor;

  const DSUserAvatar({
    Key? key,
    required this.text,
    this.radius = 25.0,
    this.backgroundColor = DSColors.primaryGreensTrue,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: DSBodyText(
        text: RegExp(r'\b[A-a-Z-z]')
            .allMatches(text)
            .map((m) => m.group(0))
            .join()
            .toUpperCase(),
        color: textColor,
      ),
    );
  }
}
