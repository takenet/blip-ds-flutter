import 'dart:math';

import 'package:flutter/material.dart';

class DSLinearGradient extends LinearGradient {
  final double degree;
  
  DSLinearGradient({
    required super.colors,
    required this.degree,
  }) : super(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          transform: GradientRotation(degree * (pi / 180.0)),
        );
}
