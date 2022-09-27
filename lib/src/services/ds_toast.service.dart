import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/enums/ds_toast_type.enum.dart';

/// A Design System's [Dialog] used to display a dialog box.
class DSToastService {
  String? title;
  final String text;
  final DSActionType actionType;
  final BuildContext context;
  final String? buttonText;
  final Function? onPressedButton;
  final double? positionOffset;

  late Color backgroundColor = Colors.white;
  final Color titleColor = DSColors.neutralDarkCity;
  final Color textColor = DSColors.neutralDarkCity;
  final Color shadowColor = const Color(0xFF202C44).withOpacity(0.24);
  late Widget mainButton;
  late Widget icon;

  Flushbar? flushBar;

  /// Creates a new Design System's [Dialog]
  DSToastService({
    this.title,
    required this.text,
    required this.context,
    this.actionType = DSActionType.icon,
    this.buttonText,
    this.onPressedButton,
    this.positionOffset = 16.0,
  })  : assert((actionType == DSActionType.button) ? buttonText != null : true),
        assert((actionType == DSActionType.button)
            ? onPressedButton != null
            : true);

  void _show(final DSToastType type) async {
    _prepareToast(type);

    flushBar = await Flushbar(
      icon: icon,
      titleColor: titleColor,
      messageColor: textColor,
      isDismissible: true,
      shouldIconPulse: false,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      animationDuration: DSUtils.defaultAnimationDuration,
      positionOffset: positionOffset!,
      boxShadows: [
        BoxShadow(
          color: shadowColor,
          spreadRadius: 0.5,
          blurRadius: 15.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
      mainButton: _setMainButton(),
      backgroundColor: backgroundColor,
      maxWidth: MediaQuery.of(context).size.width - 16.0,
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
      margin: const EdgeInsets.only(bottom: 0.0),
      title: title,
      message: text,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  Future<void> _prepareToast(final DSToastType type) async {
    switch (type) {
      case DSToastType.success:
        backgroundColor = DSColors.primaryGreensMint;
        icon = SvgPicture.asset(
          'assets/images/icon_success.svg',
          package: DSUtils.packageName,
          height: 22.0,
          width: 22.0,
        );
        //_setMainButton();
        break;
      case DSToastType.warning:
        backgroundColor = DSColors.primaryYellowsCorn;
        icon = Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 8.0),
          child: Image.asset(
            'assets/images/icon_alert_warning.png',
            width: 22.0,
            height: 22.0,
            package: DSUtils.packageName,
          ),
        );
        break;
      case DSToastType.error:
        backgroundColor = DSColors.extendRedsFlower;
        icon = Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 8.0),
          child: Image.asset(
            'assets/images/icon_alert_error.png',
            width: 22.0,
            height: 22.0,
            package: DSUtils.packageName,
          ),
        );
        break;
      case DSToastType.system:
        backgroundColor = DSColors.illustrationBlueGenie;
        icon = Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 8.0),
          child: SvgPicture.asset(
            'assets/images/icon_blip.svg',
            //color: DSColors.neutralDarkRooftop,
            package: DSUtils.packageName,
            height: 22.0,
            width: 22.0,
          ),
        );
        break;
      case DSToastType.notification:
        backgroundColor = DSColors.neutralLightSnow;
        icon = Container(
          padding: const EdgeInsets.only(bottom: 18.0),
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
            padding: const EdgeInsets.only(bottom: 22.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          )
        : Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: DSTertiaryButton(
              onPressed: () => onPressedButton!(),
              label: buttonText,
            ),
          );
  }

  void warning() {
    _show(DSToastType.warning);
  }

  /// Shows a [DSDialogType.system] dialog box type
  void system() {
    _show(DSToastType.system);
  }

  /// Shows a [DSDialogType.error] dialog box type
  void error() {
    _show(DSToastType.error);
  }

  /// Shows a [DSDialogType.error] dialog box type
  void success() {
    _show(DSToastType.success);
  }

  /// Shows a [DSDialogType.error] dialog box type
  void notification() {
    _show(DSToastType.notification);
  }
}
