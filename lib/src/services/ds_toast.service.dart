import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/enums/ds_toast_type.enum.dart';
import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';

/// A Design System's [Dialog] used to display a dialog box.
class DSToastService {
  final String title;
  final String text;
  final DSButton firstButton;
  final DSButton? secondButton;
  final BuildContext context;

  late Color backgroundColor = Colors.white;
  final Color titleColor = DSColors.neutralDarkCity;
  final Color textColor = DSColors.neutralDarkCity;
  final Color shadowColor = const Color(0xFF202C44);
  late Widget mainButton;
  late Widget icon;

  /// Creates a new Design System's [Dialog]
  DSToastService({
    required this.title,
    required this.text,
    required this.context,
    required this.firstButton,
    this.secondButton,
  });

  void _show(final DSToastType type) async {
    _prepareToast(type);

    Flushbar(
      icon: icon,
      titleColor: titleColor,
      messageColor: textColor,
      isDismissible: true,
      shouldIconPulse: false,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      boxShadows: [
        BoxShadow(
          color: shadowColor,
          spreadRadius: 5,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
      mainButton: Container(
        padding: const EdgeInsets.only(bottom: 25),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      backgroundColor: backgroundColor,
      maxWidth: MediaQuery.of(context).size.width - 20.0,
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
      title: title,
      message: text,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  Future<void> _prepareToast(final DSToastType type) async {
    switch (type) {
      case DSToastType.success:
        backgroundColor = DSColors.primaryGreensMint;
        icon = const Padding(
          padding: EdgeInsets.only(bottom: 17),
          child: Icon(Icons.ac_unit),
        );
        break;
      case DSToastType.warning:
        backgroundColor = DSColors.primaryYellowsCorn;
        icon = const Padding(
          padding: EdgeInsets.only(bottom: 17),
          child: Icon(Icons.ac_unit),
        );
        break;
      case DSToastType.error:
        backgroundColor = DSColors.extendRedsFlower;
        icon = const Padding(
          padding: EdgeInsets.only(bottom: 17),
          child: Icon(Icons.ac_unit),
        );
        break;
      case DSToastType.system:
        backgroundColor = DSColors.illustrationBlueGenie;
        icon = const Padding(
          padding: EdgeInsets.only(bottom: 17),
          child: Icon(Icons.ac_unit),
        );
        break;
      case DSToastType.notification:
        backgroundColor = DSColors.neutralLightSnow;
        icon = Container(
          padding: const EdgeInsets.only(bottom: 10),
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

  /// Shows a [DSDialogType.warning] dialog box type
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
