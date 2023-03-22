import 'dart:async';

import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DSRecordStatus extends StatefulWidget {
  const DSRecordStatus({
    super.key,
  });

  @override
  State<DSRecordStatus> createState() => _DSRecordStatusState();
}

class _DSRecordStatusState extends State<DSRecordStatus> {
  final shouldFadeIn = RxBool(true);
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateRecordStatusFade(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Obx(
        () => AnimatedOpacity(
          opacity: shouldFadeIn.value ? 1.0 : 0.0,
          duration: const Duration(
            milliseconds: 200,
          ),
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: DSColors.extendRedsDelete,
            ),
          ),
        ),
      );

  Future<void> _updateRecordStatusFade() async {
    await Future.delayed(DSUtils.defaultAnimationDuration);

    shouldFadeIn.value = false;

    await Future.delayed(DSUtils.defaultAnimationDuration);

    shouldFadeIn.value = true;
  }
}
