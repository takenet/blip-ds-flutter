import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../enums/ds_dialog_type.enum.dart';
import '../themes/colors/ds_colors.theme.dart';
import '../themes/icons/ds_icons.dart';
import '../themes/system_overlay/ds_system_overlay.style.dart';
import '../widgets/texts/ds_body_text.widget.dart';
import '../widgets/texts/ds_headline_small_text.widget.dart';
import 'ds_context.service.dart';

/// A Design System's [Dialog] used to display a dialog box.
class DSDialogService {
  /// Creates a new Design System's [Dialog]
  DSDialogService({
    required this.title,
    required this.text,
    this.primaryButton,
    this.secondaryButton,
    final BuildContext? context,
  }) : context = context ?? DSContextService.overlayContext!;

  final String title;
  final String text;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final BuildContext context;

  DSDialogType type = DSDialogType.system;

  bool _isDialogOpen = false;
  bool get isDialogOpen => _isDialogOpen;

  /// Shows a [DSDialogType.warning] dialog box type
  Future<T?> showWarning<T>() => _show<T>(
        type: DSDialogType.warning,
      );

  /// Shows a [DSDialogType.system] dialog box type
  Future<T?> showSystem<T>() => _show<T>(
        type: DSDialogType.system,
      );

  /// Shows a [DSDialogType.error] dialog box type
  Future<T?> showError<T>() => _show<T>(
        type: DSDialogType.error,
      );

  Future<T?> _show<T>({
    required final DSDialogType type,
  }) {
    this.type = type;

    _isDialogOpen = true;

    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (_) => _buildDialog(type),
    ).then((value) {
      _isDialogOpen = false;

      return value;
    });
  }

  Widget _buildDialog(final DSDialogType type) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: DSSystemOverlayStyle.light,
      child: PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400.0),
            decoration: BoxDecoration(
              color: DSColors.neutralLightSnow,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                  color: DSColors.neutralDarkEclipse.withValues(
                    alpha: 0.4,
                  ),
                  blurRadius: 15.0,
                  offset: const Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildBody(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final Color header = type == DSDialogType.system
        ? DSColors.primaryLight
        : type == DSDialogType.warning
            ? DSColors.primaryYellowsCorn
            : DSColors.extendRedsFlower;

    late final IconData icon;

    switch (type) {
      case DSDialogType.error:
        icon = DSIcons.error_outline;
        break;
      case DSDialogType.warning:
        icon = DSIcons.warning_outline;
        break;
      default:
        icon = DSIcons.info_outline;
    }

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
            Icon(
              icon,
              size: 32,
              color: DSColors.neutralDarkCity,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DSHeadlineSmallText(
                  title,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DSBodyText(
        text,
        overflow: TextOverflow.clip,
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (secondaryButton != null)
            Flexible(
              child: secondaryButton!,
            ),
          if (primaryButton != null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: primaryButton,
              ),
            ),
        ],
      ),
    );
  }
}
