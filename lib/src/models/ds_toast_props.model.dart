import 'package:flutter/foundation.dart';

import '../enums/ds_toast_action_type.enum.dart';
import '../enums/ds_toast_type.enum.dart';

class DSToastProps {
  /// Creates a new Design System's [DSToastProps]
  DSToastProps({
    this.title,
    this.message,
    this.actionType = DSToastActionType.icon,
    this.buttonText,
    this.onPressedButton,
    this.toastDuration,
    this.positionOffset = 60.0,
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
  final double positionOffset;

  /// Set a time value in milliseconds using the [toastDuration] parameter to
  /// keep the toast on the screen without closing. If you set the value to 0, the toast
  /// will not close automatically, depending on a manual action.
  final int? toastDuration;

  /// [DSToast] type that will be automatically set
  DSToastType type = DSToastType.system;

  /// [DSToast] unique key that will be automatically set
  UniqueKey? key;
}
