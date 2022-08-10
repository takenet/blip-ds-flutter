import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DSSwitchTile extends StatelessWidget {
  /// Create a tile widget with a switch button
  ///
  ///It is mandatory to inform three parameters: [value], enabling or disabling the switch, [onChanged], the event that will be executed when changing the value, and [title], which is the title of the tile.
  const DSSwitchTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.switchActiveColor = DSColors.primaryNight,
    this.switchInactiveColor = DSColors.neutralMediumSilver,
    this.leading,
    this.isEnabled = true,
    this.contentPadding,
  }) : super(key: key);

  /// current state of the switch widget.
  final bool value;

  /// Similar to [Switch.onChanged] and [CupertinoSwitch.onChanged].
  final ValueChanged<bool> onChanged;

  final Widget? title;

  /// Switch button and title line color when [value] is true.
  final Color? switchActiveColor;

  /// Switch button color when [value] is false.
  final Color? switchInactiveColor;

  /// Make it possible to use an image, icon, avatar or other widget together with the switch before the title.
  final Widget? leading;

  /// Enables or disables the widget by changing the color of the switch.
  final bool isEnabled;

  /// Change a padding tile content.
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme.merge(
      selectedColor: switchActiveColor,
      child: ListTile(
        enabled: isEnabled,
        onTap: () => onChanged(!value),
        leading: leading,
        title: title,
        trailing: DSCustomSwitch(
          activeColor: isEnabled ? switchActiveColor : switchInactiveColor,
          inactiveColor: switchInactiveColor,
          value: value,
          onChanged: onChanged,
        ),
        contentPadding: contentPadding,
        selected: value,
      ),
    );
  }
}
