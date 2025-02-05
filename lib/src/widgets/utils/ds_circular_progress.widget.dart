import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/ds_theme.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../texts/ds_caption_small_text.widget.dart';

class DSCircularProgress extends StatelessWidget {
  final RxInt maximumProgress;
  final RxInt currentProgress;
  final Color? foregroundColor;

  const DSCircularProgress({
    super.key,
    required this.maximumProgress,
    required this.currentProgress,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final double percent = maximumProgress.value > 0
            ? currentProgress.value / maximumProgress.value
            : 0;

        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: DSColors.primary,
                  backgroundColor: Colors.grey,
                  value: currentProgress.value < maximumProgress.value
                      ? percent
                      : null,
                ),
              ),
              if (currentProgress.value > 0 && maximumProgress.value > 0)
                DSCaptionSmallText(
                  _buildProgress(),
                  color: foregroundColor ?? DSThemeService.foregoundColor,
                )
            ],
          ),
        );
      },
    );
  }

  String _buildProgress() {
    String getSize(int value) => FileSize.getSize(
          value,
          precision: PrecisionValue.One,
        );

    return '${getSize(currentProgress.value)} / ${getSize(maximumProgress.value)}';
  }
}
