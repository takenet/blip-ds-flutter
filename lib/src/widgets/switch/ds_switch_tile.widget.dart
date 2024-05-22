import 'package:flutter/material.dart';

import 'ds_switch.widget.dart';
import 'ds_switch_base.widget.dart';

class DSSwitchTile extends DSSwitchBase {
  /// Create a tile widget with a switch button
  ///
  /// It is mandatory to inform three parameters: [value], enabling or disabling the switch, [onChanged],
  /// the event that will be executed when changing the value, and [title], which is the title of the tile.
  const DSSwitchTile({
    super.key,
    required super.value,
    required super.onChanged,
    super.isEnabled = true,
    required this.title,
    this.leading,
    this.contentPadding,
  });

  /// Switchtile title to be shown referring to the switch
  final Widget? title;

  /// Make it possible to use an image, icon, avatar or other widget together with the switch before the title.
  final Widget? leading;

  /// Change a padding tile content.
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: isEnabled,
      onTap: () => onChanged(!value),
      leading: leading,
      title: title,
      trailing: DSSwitch(
        value: value,
        onChanged: onChanged,
        isEnabled: isEnabled,
      ),
      contentPadding: contentPadding,
    );
  }
}
