import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSDialog {
  final String title;
  final String text;
  final String firstButtonText;
  final String? secondButtonText;
  final void Function() firstButtonPressed;
  final void Function()? secondButtonPressed;

  final BuildContext context;

  DSDialog(
      {required this.title,
      required this.text,
      required this.firstButtonText,
      required this.firstButtonPressed,
      this.secondButtonText,
      this.secondButtonPressed,
      required this.context});

  _show() {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22.0))),
            titlePadding: EdgeInsets.zero,
            title: Container(
              decoration: const BoxDecoration(
                color: DSColors.primaryLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.0),
                  topRight: Radius.circular(22.0),
                ),
              ),
              height: 64.0,
              child: Text(title),
            ),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: firstButtonPressed,
                child: Text(firstButtonText),
              ),
              if (secondButtonText != null)
                TextButton(
                  onPressed: secondButtonPressed,
                  child: Text(secondButtonText!),
                )
            ],
          ),
        );
      },
    );
  }

  warning() {
    _show();
  }
}
