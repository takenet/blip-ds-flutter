import 'package:flutter/material.dart';

abstract class DSSwitchBase extends StatelessWidget {
  const DSSwitchBase({
    Key? key,
    required this.onChanged,
    required this.value,
    this.isEnabled = true,
  }) : super(
          key: key,
        );

  /// Callback performed when changing status [value]
  final ValueChanged<bool> onChanged;

  /// Enables or disables the widget by changing the color of the switch
  /// and preventing the status from changing
  final bool isEnabled;

  /// Referring to [value] true or false, preventing from
  /// changing status and activating [onChanged].
  final bool value;
}
