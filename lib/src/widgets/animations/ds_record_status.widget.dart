import 'dart:async';

import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';

class DSRecordStatus extends StatefulWidget {
  const DSRecordStatus({
    super.key,
  });

  @override
  State<DSRecordStatus> createState() => _DSRecordStatusState();
}

class _DSRecordStatusState extends State<DSRecordStatus>
    with SingleTickerProviderStateMixin {
  final _totalAnimationCycle = const Duration(seconds: 1);
  late final Timer? _timer;

  late final _animationController = AnimationController(
    vsync: this,
    duration: _getAnimationCycleByDividend(4),
  );

  late final _opacity = Tween<double>(
    begin: 1.0,
    end: 0.0,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ),
  );

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      _getAnimationCycleByDividend(2),
      (_) => _animationController.isDismissed
          ? _animationController.forward()
          : _animationController.reverse(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _opacity,
        child: Container(
          width: 8.0,
          height: 8.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: DSColors.extendRedsDelete,
          ),
        ),
      );

  Duration _getAnimationCycleByDividend(
    final int dividend,
  ) =>
      Duration(
        milliseconds: (_totalAnimationCycle.inMilliseconds / dividend).ceil(),
      );
}
