import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSBottomSheetService {
  final BuildContext context;
  final Widget child;

  DSBottomSheetService({
    required this.context,
    required this.child,
  });

  Widget _buildBottomSheet({ScrollController? controller}) {
    final window = WidgetsBinding.instance.window;
    final padding = MediaQueryData.fromWindow(window).padding.bottom + 36;

    return Container(
      margin: EdgeInsets.only(
        top: MediaQueryData.fromWindow(window).padding.top + 10,
      ),
      decoration: const BoxDecoration(
        color: DSColors.neutralLightSnow,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 4.0,
                  width: 32.0,
                  decoration: const BoxDecoration(
                    color: DSColors.neutralMediumWave,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
              ),
              child: controller != null
                  ? SingleChildScrollView(
                      controller: controller,
                      child: _buildChild(padding),
                    )
                  : _buildChild(padding),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChild(double padding) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: padding,
      ),
      child: child,
    );
  }

  void showDraggable({
    final double minSize = 0.25,
    final double initSize = 0.5,
  }) {
    showModalBottomSheet<void>(
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

  void show() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => _buildBottomSheet(),
    );
  }
}
