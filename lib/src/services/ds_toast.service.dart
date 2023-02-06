import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:blip_ds/blip_ds.dart';

import '../enums/ds_toast_type.enum.dart';

/// A Design System's [DSToastService] used to display a toast.
class DSToastService {
  /// Creates a new Design System's [DSToastService]
  DSToastService({
    this.title,
    this.message,
    this.actionType = DSToastActionType.icon,
    this.buttonText,
    this.onPressedButton,
    this.toastDuration,
    this.positionOffset = 16.0,
  })  : assert(
          (actionType == DSToastActionType.button &&
                  buttonText != null &&
                  onPressedButton != null) ||
              actionType != DSToastActionType.button,
        ),
        assert(
          (title?.isNotEmpty ?? false) || (message?.isNotEmpty ?? false),
        );

  /// Use [title] to show title in toast.
  ///
  /// The [title] parameter is optional. If not defined, it will not be shown.
  final String? title;

  /// Use [message] to show the message below the title in the toast
  final String? message;

  /// Use [actionType] to set the action type of the toast output resource
  /// [DSActionType.icon] or [DSActionType.button].
  final DSToastActionType actionType;

  /// If you want to replace the close icon with a custom one, use the [buttonText]
  /// parameter to define the name
  final String? buttonText;

  /// When using a custom button, it is possible to define a callback
  /// function to perform some action. Use the [onPressedButton] parameter.
  final Function? onPressedButton;

  /// Use [positionOffset] to position the toast, moving up relative to the bottom of the screen.
  final double? positionOffset;

  /// Set a time value in milliseconds using the [toastDuration] parameter to
  /// keep the toast on the screen without closing. If you set the value to 0, the toast
  /// will not close automatically, depending on a manual action.
  final int? toastDuration; // miliseconds

  /// Button widget to show
  Widget? mainButton;

  /// Icon widget to show
  Widget? icon;

  /// Overlay, where the toast will be overlayed
  OverlayEntry? _overlayEntry;

  /// Color of elements in toast
  Color? backgroundColor;
  final Color titleColor = DSColors.neutralDarkCity;
  final Color textColor = DSColors.neutralDarkCity;

  /// Toast opening and closing animation duration
  final int animationDuration = 300; // miliseconds

  /// Animation scene controller
  Control? _controlAnimation = Control.stop;

  /// Toast state manager to be recreated when closing
  StateSetter? state;

  /// Timer to keep toast on screen
  Timer? _timeToastDuration;

  /// Overlay content while displaying toast
  Widget? _content;

  void _show(final DSToastType type) {
    _prepareToast(type);

    _overlayEntry = createOverlayEntry();

    Overlay.of(Get.overlayContext!).insert(_overlayEntry!);

    _controlAnimation = Control.playFromStart;
  }

  OverlayEntry createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);

        _content ??= Positioned(
          bottom: mediaQuery.viewPadding.bottom + 70 + positionOffset!,
          width: mediaQuery.size.width - 32.0,
          left: 16.0,
          child: Dismissible(
            key: const Key('ds-toast-key'),
            onDismissed: (direction) {
              if (_overlayEntry != null) {
                _controlAnimation = Control.stop;
                _close();
              }
            },
            child: _animeCard(),
          ),
        );

        return _content!;
      },
    );
  }

  /// Create the toast card
  Material _cardToast() {
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(8.0),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            left: -15,
            top: -2,
            child: SvgPicture.asset(
              'assets/images/blip_ balloon.svg',
              package: DSUtils.packageName,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (icon != null) icon!,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          DSHeadlineSmallText(
                            title,
                            overflow: TextOverflow.visible,
                          ),
                        if (message != null)
                          DSBodyText(
                            message,
                            overflow: TextOverflow.visible,
                          ),
                      ],
                    ),
                  ),
                ),
                _setMainButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Prepares the presentation of toast elements according to the type
  void _prepareToast(final DSToastType type) {
    switch (type) {
      case DSToastType.warning:
        backgroundColor = DSColors.primaryYellowsCorn;
        icon = _setIcon(DSIcons.warning_outline);
        break;
      case DSToastType.error:
        backgroundColor = DSColors.extendRedsFlower;
        icon = _setIcon(DSIcons.error_outline);
        break;
      case DSToastType.system:
        backgroundColor = DSColors.illustrationBlueGenie;
        icon = _setIcon(DSIcons.message_ballon_outline);
        break;
      case DSToastType.notification:
        backgroundColor = Colors.transparent;
        icon = _setIcon(DSIcons.bell_outline);
        break;
      default:
        backgroundColor = DSColors.primaryGreensMint;
        icon = _setIcon(DSIcons.like_outline);
    }
  }

  /// Switches between exit button types
  Widget _setMainButton() {
    return actionType == DSToastActionType.icon
        ? DSIconButton(
            size: 40.0,
            icon: const Icon(DSIcons.close_outline),
            onPressed: () {
              state!(() {
                _stopTimer();
                _controlAnimation = Control.playReverse;
              });
            },
          )
        : actionType == DSToastActionType.button
            ? DSTertiaryButton(
                label: buttonText,
                onPressed: () {
                  onPressedButton!();
                  state!(
                    () {
                      _stopTimer();
                      _controlAnimation = Control.playReverse;
                    },
                  );
                },
              )
            : const SizedBox.shrink();
  }

  /// Create and manage the toast animation
  StatefulBuilder _animeCard() {
    double start = (MediaQuery.of(Get.context!).size.width) * -1.0;
    double end = 0.0;

    final duration = toastDuration ??
        ((message?.length ?? 0) * 100 + (title?.length ?? 0) * 100);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter mystate) {
        state = mystate;
        return CustomAnimationBuilder<double>(
          duration: Duration(milliseconds: animationDuration),
          control: _controlAnimation!,
          tween: Tween(begin: start, end: end),
          builder: (_, value, child) {
            return Transform.translate(
              offset: Offset(value, 0.0),
              child: child,
            );
          },
          child: _cardToast(),
          onCompleted: () async {
            if (toastDuration == 0) {
              if (_controlAnimation == Control.playReverse) {
                _close();
              }
            } else {
              if (_controlAnimation == Control.playFromStart) {
                _timeToastDuration = Timer(
                  Duration(milliseconds: duration),
                  () {
                    state!(
                      () {
                        _controlAnimation = Control.playReverse;
                      },
                    );
                  },
                );
              } else {
                _close();
              }
            }
          },
        );
      },
    );
  }

  Widget _setIcon(final IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Icon(
        icon,
        color: DSColors.neutralDarkCity,
        size: 24.0,
      ),
    );
  }

  void _close() {
    if (_overlayEntry != null) {
      _stopTimer();
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _stopTimer() {
    if (_timeToastDuration != null) {
      _content = null;
      _timeToastDuration!.cancel();
      _timeToastDuration = null;
    }
  }

  /// Shows a [DSToastType.warning] toast type
  void warning() {
    _close();
    _show(DSToastType.warning);
  }

  /// Shows a [DSToastType.system] toast type
  void system() {
    _close();
    _show(DSToastType.system);
  }

  /// Shows a [DSToastType.error] toast type
  void error() {
    _close();
    _show(DSToastType.error);
  }

  /// Shows a [DSToastType.success] toast type
  void success() {
    _close();
    _show(DSToastType.success);
  }

  /// Shows a [DSToastType.notification] toast type
  void notification() {
    _close();
    _show(DSToastType.notification);
  }
}
