import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/enums/ds_toast_type.enum.dart';

/// A Design System's [DSToastService] used to display a toast.
class DSToastService {
  /// Use [context] to set the toast on the current screen
  final BuildContext context;

  /// Use [title] to show title in toast
  /// O parâmetro [title] é opcional. Caso não seja definido não será mostrado
  final String? title;

  /// Use [message] to show the message below the title in the toast
  final String message;

  /// Use [actionType] to define the type of tost which can be
  /// [DSActionType.system],[DSActionType.notification],[DSActionType.success],
  /// [DSActionType.error] or [DSActionType.warning].
  final DSActionType actionType;

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
  final int toastDuration; // miliseconds

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

  /// Creates a new Design System's [DSToastService]
  DSToastService({
    this.title,
    required this.message,
    required this.context,
    this.actionType = DSActionType.icon,
    this.buttonText,
    this.onPressedButton,
    required this.toastDuration,
    this.positionOffset = 16.0,
  })  : assert((actionType == DSActionType.button) ? buttonText != null : true),
        assert((actionType == DSActionType.button)
            ? onPressedButton != null
            : true);

  void _show(final DSToastType type) async {
    _prepareToast(type);

    _overlayEntry = createOverlayEntry(
      context: context,
      message: message,
      animationDuration: animationDuration,
      toastDuration: toastDuration,
      icon: icon,
      mainButton: mainButton,
    );

    Overlay.of(context)!.insert(_overlayEntry!);

    _controlAnimation = Control.playFromStart;
  }

  OverlayEntry createOverlayEntry(
      {required BuildContext context,
      required String message,
      int? animationDuration,
      required int toastDuration,
      Widget? icon,
      Widget? mainButton,
      String? title}) {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0 + positionOffset!,
        width: MediaQuery.of(context).size.width - 16.0,
        left: 8.0,
        child: Dismissible(
          key: const Key('key'),
          onDismissed: (direction) {
            if (_overlayEntry != null) {
              _controlAnimation = Control.stop;
              _close();
            }
          },
          child: _animeCard(),
        ),
      ),
    );
  }

  /// Create the toast card
  Material _cardToast() {
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (icon != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: icon,
                ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) DSHeadlineSmallText(text: title),
                      SizedBox(
                        child: DSBodyText(
                          text: message,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: _setMainButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Prepares the presentation of toast elements according to the type
  Future<void> _prepareToast(final DSToastType type) async {
    switch (type) {
      case DSToastType.success:
        backgroundColor = DSColors.primaryGreensMint;
        icon = Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: SvgPicture.asset(
            'assets/images/icon_success.svg',
            package: DSUtils.packageName,
            height: 24.0,
            width: 24.0,
          ),
        );
        break;
      case DSToastType.warning:
        backgroundColor = DSColors.primaryYellowsCorn;
        icon = Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: Image.asset(
            'assets/images/icon_alert_warning.png',
            width: 24.0,
            height: 24.0,
            package: DSUtils.packageName,
          ),
        );
        break;
      case DSToastType.error:
        backgroundColor = DSColors.extendRedsFlower;
        icon = Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: Image.asset(
            'assets/images/icon_alert_error.png',
            width: 24.0,
            height: 24.0,
            package: DSUtils.packageName,
          ),
        );
        break;
      case DSToastType.system:
        backgroundColor = DSColors.illustrationBlueGenie;
        icon = Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: SvgPicture.asset(
            'assets/images/icon_blip.svg',
            package: DSUtils.packageName,
            height: 24.0,
            width: 24.0,
          ),
        );
        break;
      case DSToastType.notification:
        backgroundColor = DSColors.neutralLightSnow;
        icon = SizedBox(
          width: 50.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/notificacao.png',
              package: DSUtils.packageName,
            ),
          ),
        );
        break;
      default:
        DSToastType.success;
    }
  }

  /// Switches between exit button types
  Widget _setMainButton() {
    return actionType == DSActionType.icon
        ? Container(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: IconButton(
              onPressed: () {
                state!(() {
                  _stopTimer();
                  _controlAnimation = Control.playReverse;
                });
              },
              icon: const Icon(Icons.close),
            ),
          )
        : Container(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: DSTertiaryButton(
              onPressed: () {
                onPressedButton!();
                state!(
                  () {
                    _stopTimer();
                    _controlAnimation = Control.playReverse;
                  },
                );
              },
              label: buttonText,
            ),
          );
  }

  /// Create and manage the toast animation
  StatefulBuilder _animeCard() {
    double inicio = (MediaQuery.of(context).size.width) * -1.0;
    double fim = 0.0;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter mystate) {
        state = mystate;
        return CustomAnimationBuilder<double>(
          duration: Duration(milliseconds: animationDuration),
          control: _controlAnimation!,
          tween: Tween(begin: inicio, end: fim),
          builder: (context, value, child) {
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
                  Duration(milliseconds: toastDuration),
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

  void _close() {
    if (_overlayEntry != null) {
      _stopTimer();
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _stopTimer() {
    if (_timeToastDuration != null) {
      _timeToastDuration!.cancel();
      _timeToastDuration = null;
    }
  }

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
