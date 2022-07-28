import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DSFadingCircleLoadingWidget extends StatelessWidget {
  final Color color;
  final double size;

  const DSFadingCircleLoadingWidget({
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
