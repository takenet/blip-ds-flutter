import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/colors/ds_colors.theme.dart';
import '../themes/colors/ds_dark_colors.theme.dart';

class DSBottomSheetService {
  final BuildContext context;
  final Widget Function(ScrollController?) builder;
  final Widget? fixedHeader;
  final bool hasBottomInsets;
  final RxBool darkMode;

  DSBottomSheetService({
    required this.context,
    required this.builder,
    this.hasBottomInsets = true,
    this.fixedHeader,
    RxBool? darkMode,
  }) : darkMode = darkMode ?? RxBool(false);

  Widget _buildBottomSheet({
    ScrollController? controller,
    final bool hideGrabber = false,
  }) {
    final window = View.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Obx(
        () => Container(
          padding: hasBottomInsets
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                )
              : null,
          margin: EdgeInsets.only(
            top: MediaQueryData.fromView(window).padding.top + 10,
          ),
          decoration: _border(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !hideGrabber,
                replacement: Container(
                  decoration: _border(),
                ),
                child: _grabber(),
              ),
              fixedHeader ?? const SizedBox.shrink(),
              _buildChild(controller),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _border() {
    return BoxDecoration(
      color: darkMode.value ? DSDarkColors.surface3 : DSColors.neutralLightSnow,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(22.0),
        topRight: Radius.circular(22.0),
      ),
    );
  }

  Widget _grabber() {
    return Container(
      height: 30.0,
      decoration: _border(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4.0,
            width: 32.0,
            decoration: BoxDecoration(
              color: darkMode.value
                  ? DSColors.neutralLightSnow
                  : DSColors.neutralMediumWave,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChild(ScrollController? controller) {
    return Flexible(
      child: builder(controller),
    );
  }

  Future<void> showDraggable({
    final double minSize = 0.25,
    final double initSize = 1.0,
  }) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 1,
          minChildSize: minSize,
          initialChildSize: initSize,
          builder: (_, controller) => _buildBottomSheet(controller: controller),
        );
      },
    );
  }

  Future<void> show() {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) => _buildBottomSheet(),
    );
  }

  Future<void> showUndisposable() {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) => PopScope(
        canPop: false,
        child: _buildBottomSheet(
          hideGrabber: true,
        ),
      ),
      enableDrag: false,
    );
  }
}
