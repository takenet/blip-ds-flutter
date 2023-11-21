import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';

class DSUploading extends StatefulWidget {
  final double? size;
  final Color? color;

  const DSUploading({
    super.key,
    this.size,
    this.color,
  });

  @override
  State<DSUploading> createState() => _DSUploadingState();
}

class _DSUploadingState extends State<DSUploading> {
  final _visible = RxBool(false);

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _visible.value = !_visible.value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => AnimatedOpacity(
          opacity: _visible.value ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: Icon(
            DSIcons.upload_outline,
            color: widget.color ?? DSColors.neutralLightSnow,
            size: widget.size ?? 24.0,
          ),
        ),
      ),
    );
  }
}
