import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// A Design System's animated spinner fading circle primarily used by loading scenarios.
class DSFadingCircleLoading extends StatelessWidget {
  final Color color;
  final double size;

  /// A Design System's animated spinner fading circle primarily used by loading scenarios.
  const DSFadingCircleLoading({
    Key? key,
    required this.color,
    this.size = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: color,
      size: size,
    );
  }
}
