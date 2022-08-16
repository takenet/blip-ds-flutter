import 'package:flutter/material.dart';

class DSSwitchBase extends StatelessWidget {
  const DSSwitchBase({
    Key? key,
    required this.onChanged,
    required this.isActive,
    this.isEnabled = true,
  }) : super(
          key: key,
        );

  /// Callback performed when changing status [isActive]
  final ValueChanged<bool> onChanged;

  /// Enables or disables the widget by changing the color of the switch
  /// and preventing the status from changing
  final bool isEnabled;

  /// Referring to [isActive] true or false, preventing from
  /// changing status and activating [onChanged].
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
