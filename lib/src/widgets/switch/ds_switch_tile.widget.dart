import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSSwitchTile extends StatelessWidget {
  /// Create a tile widget with a switch button
  ///
  ///It is mandatory to inform three parameters: [isActive], enabling or disabling the switch, [onChanged], the event that will be executed when changing the value, and [title], which is the title of the tile.
  const DSSwitchTile({
    Key? key,
    required this.isActive,
    required this.onChanged,
    required this.title,
    this.leading,
    this.isEnabled = true,
    this.contentPadding,
  }) : super(key: key);

  /// Current state of the switch widget.
  final bool isActive;

  /// Callback performed when changing status [isActive]
  final ValueChanged<bool> onChanged;

  /// Switchtile title to be shown referring to the switch
  final Widget? title;

  /// Make it possible to use an image, icon, avatar or other widget together with the switch before the title.
  final Widget? leading;

  /// Enables or disables the widget switch by changing the color of the switch.
  final bool isEnabled;

  /// Change a padding tile content.
  final EdgeInsetsGeometry? contentPadding;

  /// Referring to [inactiveColor] for  [isActive] false,
  final Color inactiveColor = DSColors.neutralMediumSilver;

  /// Color for background of the switch widget when [isActive] is true.
  final Color activeColor = DSColors.primaryNight;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: isEnabled,
      onTap: () => onChanged(!isActive),
      leading: leading,
      title: title,
      trailing: DSSwitch(
        isActive: isActive,
        isEnabled: isEnabled,
        onChanged: onChanged,
      ),
      contentPadding: contentPadding,
      selected: isActive,
    );
  }
}
