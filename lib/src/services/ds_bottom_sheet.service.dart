import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

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
      decoration: _border(),
      child: Stack(
        children: [
          controller != null
              ? ListView(
                  controller: controller,
                  children: [
                    StickyHeader(
                      overlapHeaders: false,
                      header: _grabber(),
                      content: _buildChild(padding),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _grabber(),
                    _buildChild(padding),
                  ],
                ),
        ],
      ),
    );
  }

  BoxDecoration _border() {
    return const BoxDecoration(
      color: DSColors.neutralLightSnow,
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
            decoration: const BoxDecoration(
              color: DSColors.neutralMediumWave,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar(double padding) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: padding,
      ),
      child: child,
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
      context: context,
      builder: (_) => _buildBottomSheet(),
    );
  }
}
