import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/enums/ds_dialog_type.enum.dart';
import 'package:blip_ds/src/widgets/buttons/ds_button.widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A Design System's [Dialog] used to display a dialog box.
class DSDialog {
  final String title;
  final String text;
  final DSButton firstButton;
  final DSButton? secondButton;
  final BuildContext context;

  /// Creates a new Design System's [Dialog]
  DSDialog({
    required this.title,
    required this.text,
    required this.context,
    required this.firstButton,
    this.secondButton,
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

      final String icon = 'assets/images/icon_alert_${describeEnum(type)}.png';

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
              Image.asset(
                icon,
                package: DSUtils.packageName,
                width: 28.0,
              ),
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
        padding: const EdgeInsets.all(16.0),
        child: DSBodyText(
          text: text,
          overflow: TextOverflow.clip,
        ),
      );
    }

    Widget buildFooter() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (secondButton != null) Flexible(child: secondButton!),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: firstButton,
              ),
            ),
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
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
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

  /// Shows a [DSDialogType.warning] dialog box type
  void warning() {
    _show(DSDialogType.warning);
  }

  /// Shows a [DSDialogType.system] dialog box type
  void system() {
    _show(DSDialogType.system);
  }

  /// Shows a [DSDialogType.error] dialog box type
  void error() {
    _show(DSDialogType.error);
  }
}
