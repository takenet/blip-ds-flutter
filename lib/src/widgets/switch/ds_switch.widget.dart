import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

/// Animation duration for [DSSwitch].
const Duration _animationDuration = Duration(milliseconds: 400);

class DSSwitch extends StatelessWidget {
  /// Creates a customizable switch for use alone or in conjunction with ListTile
  ///
  /// Set the active and inactive colors using the parameters [activeColor] and [inactiveColor], and use [isActive] to turn the switch on and off.
  const DSSwitch({
    Key? key,
    required this.onChanged,
    required this.isActive,
    this.isEnabled = true,
  }) : super(key: key);

  /// Function callback to use when the [onChanged].
  final ValueChanged<bool> onChanged;

  /// Enables or disables the widget by changing the color of the switch.
  final bool isEnabled;

  /// Referring to [isActive] true ou false.
  final bool isActive;

  /// Referring to [inactiveColor] for  [isActive] false,
  final Color inactiveColor = DSColors.neutralMediumSilver;

  /// Color for background of the switch widget when [isActive] is true.
  final Color activeColor = DSColors.primaryNight;

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
              height: 32,
              width: 56,
              curve: Curves.ease,
              duration: _animationDuration,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
                color: _defineColor(),
              ),
            ),
            AnimatedAlign(
              curve: Curves.ease,
              duration: _animationDuration,
              alignment:
                  !isActive ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                height: 24,
                width: 24,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: inactiveColor,
                      spreadRadius: 0.5,
                      blurRadius: 1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _defineColor() {
    switch (isActive) {
      case (true):
        return isEnabled ? activeColor : activeColor.withOpacity(0.5);
      case (false):
        return isEnabled ? inactiveColor : inactiveColor.withOpacity(0.5);
      default:
        return activeColor;
    }
  }
}
