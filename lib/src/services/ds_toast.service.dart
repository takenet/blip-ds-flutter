import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enums/ds_toast_type.enum.dart';
import '../models/ds_toast_props.model.dart';
import '../utils/ds_utils.util.dart';
import '../widgets/toast/ds_toast.widget.dart';
import 'ds_context.service.dart';

/// A Design System's [DSToastService] used to display a toast.
abstract class DSToastService {
  static final _visibleToasts = RxList<DSToast>();
  static OverlayEntry? _overlayEntry;
  static ScrollController? _controller;

  static void _show(final DSToastProps props) {
    final toast = DSToast(
      key: UniqueKey(),
      props: props,
      onClose: _onClose,
    );

    _visibleToasts.insert(0, toast);

    if (_controller?.hasClients ?? false) {
      _controller?.animateTo(
        0,
        duration: DSUtils.defaultAnimationDuration,
        curve: Curves.easeInOut,
      );
    }

    if (_overlayEntry == null) {
      _controller = ScrollController();
      _overlayEntry = _createOverlayEntry();

      Overlay.of(DSContextService.overlayContext!).insert(_overlayEntry!);
    }
  }

  static OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final paddingBottom = mediaQuery.padding.bottom;
        final viewInsetsBottom = mediaQuery.viewInsets.bottom;

        final offset = _visibleToasts.isNotEmpty
            ? _visibleToasts[_visibleToasts.length - 1].props.positionOffset
            : 0;

        final content = Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (Rect rect) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.transparent,
                    ],
                    stops: [-1, .04],
                  ).createShader(rect),
                  blendMode: BlendMode.dstOut,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: paddingBottom + viewInsetsBottom + offset,
                      top: 0,
                    ),
                    constraints: BoxConstraints(
                      maxHeight: (mediaQuery.size.height -
                              mediaQuery.viewInsets.bottom) *
                          .50,
                    ),
                    child: Obx(
                      () {
                        return ListView(
                          controller: _controller,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          shrinkWrap: true,
                          reverse: true,
                          children: _visibleToasts,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        return content;
      },
    );
  }

  static void _onClose(DSToast toast) {
    _visibleToasts.remove(toast);

    if (_visibleToasts.isEmpty && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _controller = null;
    }
  }

  /// Shows a [DSToastType.warning] toast type
  static void warning(final DSToastProps props) {
    props.type = DSToastType.warning;

    _show(props);
  }

  /// Shows a [DSToastType.system] toast type
  static void system(final DSToastProps props) {
    props.type = DSToastType.system;

    _show(props);
  }

  /// Shows a [DSToastType.error] toast type
  static void error(final DSToastProps props) {
    props.type = DSToastType.error;

    _show(props);
  }

  /// Shows a [DSToastType.success] toast type
  static void success(final DSToastProps props) {
    props.type = DSToastType.success;

    _show(props);
  }

  /// Shows a [DSToastType.notification] toast type
  static void notification(final DSToastProps props) {
    props.type = DSToastType.notification;

    _show(props);
  }
}
