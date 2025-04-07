import 'package:flutter/material.dart';

import 'ds_icon_button.widget.dart';

class DSStopButton extends DSIconButton {
  final Color color;

  DSStopButton({
    super.key,
    required this.color,
    required super.onPressed,
    super.isLoading,
  }) : super(
          icon: Icon(
            Icons.stop_circle_outlined,
            weight: 32.0,
            color: color,
          ),
        );
}
