import 'package:flutter/material.dart';

class DSTypingDot extends StatelessWidget {
  final Color color;
  final double size;

  /// Creates a unique dot with defined size and color
  ///
  /// Set the dot size and color using the parameters [size] and [color]
  const DSTypingDot({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      height: size,
      width: size,
    );
  }
}
