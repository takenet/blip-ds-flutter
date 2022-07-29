import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final Color? color;
  final double? size;

  /// Set the dot size and color using the parameters [size] and [color]
  const DotWidget({
    Key? key,
    @required this.color,
    @required this.size,
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
