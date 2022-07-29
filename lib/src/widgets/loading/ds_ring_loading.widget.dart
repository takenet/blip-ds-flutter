import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DSRingLoading extends StatelessWidget {
  final Color color;
  final double size;
  final double lineWidth;

  const DSRingLoading({
    Key? key,
    required this.color,
    this.size = 20,
    this.lineWidth = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitRing(
      color: color,
      size: size,
      lineWidth: lineWidth,
    );
  }
}
