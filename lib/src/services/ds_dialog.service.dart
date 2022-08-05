import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/enums/ds_dialog_type.enum.dart';
import 'package:flutter/material.dart';

/// Docs 1..
class DSDialog {
  final String title;
  final String text;
  final String firstButtonText;
  final String? secondButtonText;
  final void Function() firstButtonPressed;
  final void Function()? secondButtonPressed;

  final BuildContext context;

  /// Docs 2...
  DSDialog({
    required this.title,
    required this.text,
    required this.firstButtonText,
    required this.firstButtonPressed,
    this.secondButtonText,
    this.secondButtonPressed,
    required this.context,
  });

  void _show(final DSDialogType type) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) => _buildDialog(type),
    );
  }

  Widget _buildDialog(final DSDialogType type) {
    Widget buildHeader() {
      final Color header = type == DSDialogType.system
          ? DSColors.primaryLight
          : type == DSDialogType.warning
              ? DSColors.primaryYellowsCorn
              : DSColors.extendRedsflower;

      return Container(
        height: 64.0,
        decoration: BoxDecoration(
          color: header,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Row(
            children: [
              Icon(Icons.access_alarm_rounded),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DSHeadlineSmallText(text: title),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildBody() {
      return Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: DSBodyText(
          text: text,
          overflow: TextOverflow.clip,
        ),
      );
    }

    Widget buildFooter() {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
    }

    return WillPopScope(
      onWillPop: () async => true,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
            boxShadow: [
              BoxShadow(
                color: DSColors.neutralDarkEclipse.withOpacity(0.4),
                blurRadius: 15.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              buildBody(),
              buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  /// Docs warning..
  void warning() {
    _show(DSDialogType.warning);
  }

  /// Docs system..
  void system() {
    _show(DSDialogType.system);
  }

  /// Docs error..
  void error() {
    _show(DSDialogType.error);
  }
}
