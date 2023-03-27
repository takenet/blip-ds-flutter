import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';

class DSProgressBar extends StatelessWidget {
  final double width;
  final double value;

  const DSProgressBar({
    Key? key,
    required this.width,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(1.5),
      height: 18.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: DSColors.neutralDarkEclipse,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Container(
            width: width * value / 100,
            height: 18.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: DSColors.primaryMain,
            ),
          ),
        ],
      ),
    );
  }
}
