import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/ds_utils.util.dart';
import 'ds_icon_button.widget.dart';

class DSPlayButton extends DSIconButton {
  final Color color;

  DSPlayButton({
    super.key,
    required this.color,
    required super.onPressed,
    super.isLoading,
  }) : super(
          icon: SvgPicture.asset(
            'assets/images/play.svg',
            package: DSUtils.packageName,
            color: color,
            height: 24.0,
          ),
        );
}
