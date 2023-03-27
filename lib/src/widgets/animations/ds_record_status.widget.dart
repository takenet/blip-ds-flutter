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
  late final Timer _timer;

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
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
      const Duration(
        milliseconds: 500,
      ),
      (_) => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
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
}
