import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/enums/ds_toast_type.enum.dart';

/// A Design System's [Dialog] used to display a dialog box.
class DSToastService {
  final BuildContext context;
  final String? title;
  final String message;
  final DSActionType actionType;
  final String? buttonText;
  final Function? onPressedButton;
  final double? positionOffset;
  final int toastDuration;

  Widget? mainButton;
  Widget? icon;

  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;

  late Color backgroundColor = Colors.white;
  final Color titleColor = DSColors.neutralDarkCity;
  final Color textColor = DSColors.neutralDarkCity;
  final Color shadowColor = const Color(0xFF202C44).withOpacity(0.24);
  int animationDuration = 300; // miliseconds

  static Control? _controlAnimation = Control.stop;

  StateSetter? state;
  static Timer? timeToastDuration;

  /// Creates a new Design System's [Dialog]
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

    //if (toastTimer == null || !toastTimer!.isActive) {
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

    //Control.play;
    //Control.playReverse;

    /*
      toastTimer = Timer(
        Duration(
          milliseconds: (toastDuration * 1000) + (animationDuration * 2),
        ),
        () {
          if (_overlayEntry != null) {
            _overlayEntry!.remove();
          }
        },
      );
      */
    //}
  }

  static close() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      if (timeToastDuration!.isActive) timeToastDuration!.cancel();
      //_controlAnimation = Control.stop;
    }
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
        bottom: 50.0,
        width: MediaQuery.of(context).size.width - 16.0,
        left: 8,
        child: Dismissible(
          key: const Key('key'),
          onDismissed: (direction) {
            if (_overlayEntry != null) {
              //_controlAnimation = Control.stop;
              close();
            }
            //Control.stop;
          },
          child: _animeCard(),
          //ToastAnimation(
          //  animationDuration: animationDuration!,
          //  toastDuration: toastDuration,
          //  control: controlAnimation,
          //  child: _cardToast(),
          //),
        ),
      ),
    );
  }

  Material _cardToast() {
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10.0),
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
                  //width: 60,
                  child: icon,
                ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DSHeadlineSmallText(text: title),
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
        //_setMainButton();
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
            //color: DSColors.neutralDarkRooftop,
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

  Widget _setMainButton() {
    return actionType == DSActionType.icon
        ? Container(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: IconButton(
              onPressed: () {
                state!(() {
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
                state!(() {
                  _controlAnimation = Control.playReverse;
                });
              },
              label: buttonText,
            ),
          );
  }

  void warning() {
    DSToastService.close();
    _show(DSToastType.warning);
  }

  /// Shows a [DSDialogType.system] dialog box type
  void system() {
    close();
    _show(DSToastType.system);
  }

  /// Shows a [DSDialogType.error] dialog box type
  void error() {
    close();
    _show(DSToastType.error);
  }

  /// Shows a [DSDialogType.error] dialog box type
  void success() {
    close();
    _show(DSToastType.success);
  }

  /// Shows a [DSDialogType.error] dialog box type
  void notification() {
    close();
    _show(DSToastType.notification);
  }

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
            offset: Offset(value, 0),
            child: child,
          );
        },
        child: _cardToast(),
        onCompleted: () async {
          if (toastDuration > 0) {
            // futureDelay =
            await Future.delayed(Duration(seconds: toastDuration));
            timeToastDuration = Timer(Duration(seconds: toastDuration), () {});

            state!(() {
              if (_controlAnimation == Control.playFromStart) {
                _controlAnimation = Control.playReverse;
              }
            });
          } else {
            //state!(() {
            if (_controlAnimation == Control.playReverse) {
              _controlAnimation = Control.stop;
              //close();
            }
            //});
          }
          //state!(() {
          //  if (_controlAnimation == Control.playFromStart) {
          //    _controlAnimation = Control.playReverse;
          //  } else if (_controlAnimation == Control.playReverse) {
          //    _controlAnimation = Control.stop;
          //    close();
          //  }
          //});
        },
      );
    });
  }
}

class ToastAnimation extends StatelessWidget {
  final Widget child;
  final int toastDuration;
  final int animationDuration;
  final Control control;

  const ToastAnimation({
    super.key,
    required this.child,
    required this.toastDuration,
    required this.animationDuration,
    required this.control,
  });

  @override
  Widget build(BuildContext context) {
    double inicio = (MediaQuery.of(context).size.width) * -1.0;
    double fim = 0.0;

    //Control control = Control.play;
/*
    final tween = MovieTween()
      ..tween(
        'x',
        Tween(begin: inicio, end: fim),
        duration: const Duration(milliseconds: 200),
      )
          .thenTween(
            'x',
            Tween(begin: fim, end: fim),
            duration: Duration(seconds: toastDuration),
          )
          .thenTween(
            'x',
            Tween(begin: fim, end: inicio),
            duration: const Duration(milliseconds: 200),
          );
*/
    return CustomAnimationBuilder<double>(
        duration: const Duration(seconds: 1),
        control: control,
        tween: Tween(begin: inicio, end: fim),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value, 0),
            child: child,
          );
        },
        child: child);

    /*
    return PlayAnimationBuilder<Movie>(
      tween: tween,
      duration: tween.duration,
      curve: Curves.easeInOutSine,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value.get('x'), 0.0),
          child: child,
        );
      },
      child: child,
    );
    */
  }
}
