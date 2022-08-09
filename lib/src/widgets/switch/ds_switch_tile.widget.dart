import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Create a tile widget with a switch button
///
///It is mandatory to inform three parameters: [value], enabling or disabling the switch, [onChanged], the event that will be executed when changing the value, and [title], which is the title of the tile.
class DsSwitchTile extends StatelessWidget {
  const DsSwitchTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.switchScale = 1.0,
    this.switchActiveColor = DSColors.primaryNight,
    this.switchInactiveColor = DSColors.neutralMediumSilver,
    this.leading,
    this.isEnabled = true,
    this.contentPadding,
  })  : assert(switchScale <= 1.5),
        super(key: key);

  /// current state of the switch widget.
  final bool value;

  /// Similar to [Switch.onChanged] and [CupertinoSwitch.onChanged].
  final ValueChanged<bool> onChanged;

  final Widget? title;

  /// Indicates the size of the switch button that will be displayed.
  final double switchScale;

  /// Switch button and title line color when [value] is true.
  final Color? switchActiveColor;

  /// Color value when switch is [value] is false.
  final Color? switchInactiveColor;

  /// Referring to properties of [ListTile]
  /// Values directly mapped into the [ListTileSwitch].
  final Widget? leading;

  final bool isEnabled;

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
        trailing: Builder(
          builder: (_) => Transform.scale(
            alignment: Alignment.center,
            scale: switchScale,
            child: CupertinoSwitch(
              activeColor: isEnabled ? switchActiveColor : switchInactiveColor,
              trackColor: switchInactiveColor,
              value: value,
              onChanged: onChanged,
            ),
          ),
        ),
        contentPadding: contentPadding,
        selected: value,
      ),
    );
  }
}
