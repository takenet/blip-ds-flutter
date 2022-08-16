import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/switch/ds_switch_base.widget.dart';
import 'package:flutter/material.dart';

class DSSwitch extends DSSwitchBase {
  /// Creates a customizable switch for use alone or in conjunction with ListTile
  ///
  /// Set the active and inactive colors using the parameters [activeColor]
  /// and [inactiveColor], and use [isActive] to turn the switch on and off.
  const DSSwitch({
    Key? key,
    required super.onChanged,
    required super.isActive,
    super.isEnabled = true,
  }) : super(
          key: key,
        );

  /// Animation duration for [DSSwitch] when activate or deactivate.
  final Duration _animationDuration = const Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEnabled) onChanged(!isActive);
      },
      child: SizedBox(
        height: 32,
        width: 56,
        child: Stack(
          children: [
            AnimatedContainer(
              curve: Curves.ease,
              duration: _animationDuration,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                color: _colorSwitchDefine(),
              ),
            ),
            AnimatedAlign(
              curve: Curves.ease,
              duration: _animationDuration,
              alignment:
                  !isActive ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 24,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: DSColors.neutralLightSnow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _colorSwitchDefine() {
    switch (isActive) {
      case (true):
        return isEnabled
            ? super.activeColor
            : super.activeColor.withOpacity(0.5);
      case (false):
        return isEnabled
            ? super.inactiveColor
            : super.inactiveColor.withOpacity(0.5);
      default:
        return activeColor;
    }
  }
}
