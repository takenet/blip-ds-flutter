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
      child: DSHeadlineSmallText(
        text: text.initials(),
        color: textColor,
      ),
    );
  }
}

extension on String {
  String initials() {
    String result = "";
    List<String> words = split(" ");
    for (var element in words) {
      if (element.isNotEmpty && result.length < 2) {
        result += element[0];
      }
    }

    return result.trim().toUpperCase();
  }
}
