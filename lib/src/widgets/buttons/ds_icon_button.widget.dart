import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../animations/ds_fading_circle_loading.widget.dart';

const _kSize = Size(44.0, 44.0);

class DSIconButton extends InkWell {
  DSIconButton({
    super.key,
    required void Function() onPressed,
    required Widget icon,
    bool isLoading = false,
  }) : super(
          onTap: isLoading ? null : onPressed,
          child: SizedBox.fromSize(
            size: _kSize,
            child: Center(
              child: isLoading
                  ? const DSFadingCircleLoading(
                      color: DSColors.neutralDarkRooftop,
                      size: 25,
                    )
                  : icon,
            ),
          ),
        );
}
