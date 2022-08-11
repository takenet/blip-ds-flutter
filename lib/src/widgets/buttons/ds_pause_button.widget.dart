import 'package:flutter/material.dart';

class DSPauseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;

  const DSPauseButton({Key? key, required this.onPressed, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 1,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildVerticalBar(),
          _buildVerticalBar(),
        ],
      ),
      iconSize: 42.0,
      onPressed: onPressed,
    );
  }

  Widget _buildVerticalBar() {
    return Container(
      width: 9.0,
      height: 26.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      ),
    );
  }
}
