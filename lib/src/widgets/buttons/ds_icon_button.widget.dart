import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../animations/ds_spinner_loading.widget.dart';

class DSIconButton extends InkWell {
  DSIconButton({
    super.key,
    required void Function() onPressed,
    required Widget icon,
    final bool isLoading = false,
    final double size = 44.0,
  }) : super(
          onTap: isLoading ? null : onPressed,
          child: SizedBox.fromSize(
            size: Size(size, size),
            child: Center(
              child: isLoading
                  ? const DSSpinnerLoading(
                      color: DSColors.primaryMain,
                      size: 24,
                      lineWidth: 4.0,
                    )
                  : icon,
            ),
          ),
        );
}
