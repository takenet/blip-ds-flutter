import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

/// Animation duration for [CustomSwitch].
@protected
const Duration _animationDuration = Duration(milliseconds: 250);

class DSCustomSwitch extends StatelessWidget {
  /// Creates a customizable switch for use alone or in conjunction with ListTile
  ///
  /// Set the active and inactive colors using the parameters [activeColor] and [inactiveColor], and use [value] to turn the switch on and off.
  const DSCustomSwitch({
    Key? key,
    required this.onChanged,
    required this.value,
    this.inactiveColor = DSColors.neutralMediumSilver,
    this.activeColor = DSColors.primaryNight,
  }) : super(key: key);

  /// Function callback to use when the [onChanged].
  final ValueChanged<bool> onChanged;

  /// Referring to [value] true ou false.
  final bool value;

  /// Referring to [inactiveColor] for  [value] false,
  final Color? inactiveColor;

  /// Color for background of the switch widget when [value] is true.
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
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
                color: value ? activeColor : inactiveColor,
              ),
            ),
            AnimatedAlign(
              curve: Curves.ease,
              duration: _animationDuration,
              alignment: !value ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                height: 24,
                width: 24,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: inactiveColor!,
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
}
