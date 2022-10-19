import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

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

    final RxBool showContainer = controller != null ? true.obs : false.obs;

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
        ),
        child: Stack(
          children: [
            IgnorePointer(
              child: SizedBox(
                height: 30.0,
                child: Row(
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
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(top: showContainer.value ? 0 : 35.0),
                child: controller != null
                    ? NotificationListener(
                        child: ListView(
                          controller: controller,
                          children: [
                            Visibility(
                              visible: showContainer.value,
                              child: Container(
                                padding: const EdgeInsets.only(top: 20.0),
                                color: Colors.transparent,
                                height: 35.0,
                              ),
                            ),
                            _buildChild(padding)
                          ],
                        ),
                        onNotification: (t) {
                          if (controller.position.pixels > 0) {
                            showContainer.value = false;
                          }

                          return true;
                        },
                      )
                    : _buildChild(padding),
              ),
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
