import 'package:flutter/material.dart';

class DSPlayButtonWidget extends StatelessWidget {
  final String imageAsset;
  final VoidCallback onPressed;

  const DSPlayButtonWidget(
      {Key? key, required this.imageAsset, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 1,
      icon: Image.asset(imageAsset),
      iconSize: 42.0,
      onPressed: onPressed,
    );
  }
}
