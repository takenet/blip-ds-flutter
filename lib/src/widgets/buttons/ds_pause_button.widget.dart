import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DSPauseButton extends DSIconButton {
  final Color color;

  DSPauseButton({
    super.key,
    required this.color,
    required super.onPressed,
    super.isLoading,
  }) : super(
          icon: SvgPicture.asset(
            'assets/images/pause.svg',
            package: DSUtils.packageName,
            color: color,
            height: 24.0,
          ),
        );
}
