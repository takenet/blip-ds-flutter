import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DSSwitchButton extends StatefulWidget {
  final String? text;
  final Widget? textStyle;
  final DSAlign alignText;
  final bool isStretched;
  final bool isBreackedLineText;
  //
  late bool isSwitched;
  final Function? onToggle;
  final Color? activedColor;
  final Color? inactivedColor;
  final Color? trackColor;
  final bool isDisabled;

  DSSwitchButton({
    Key? key,
    this.text,
    this.textStyle,
    this.alignText = DSAlign.left,
    this.isStretched = true,
    this.isBreackedLineText = false,
    //
    this.isSwitched = true,
    this.isDisabled = false,
    this.onToggle,
    this.activedColor = DSColors.primaryNight,
    this.inactivedColor = DSColors.neutralLightSnow,
    this.trackColor = DSColors.neutralMediumSilver,
  }) : super(key: key);

  @override
  State<DSSwitchButton> createState() => _DSSwitchButtonState();
}

class _DSSwitchButtonState extends State<DSSwitchButton>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {}
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: widget.isSwitched,
      onChanged: (value) {
        setState(
          () {
            widget.isSwitched = value;
            print(widget.isSwitched);
          },
        );
        if (widget.onToggle != null) widget.onToggle!();
      },
      thumbColor: widget.isDisabled
          ? DSColors.neutralMediumSilver
          : widget.inactivedColor,
      trackColor: widget.trackColor,
      activeColor: widget.isDisabled
          ? DSColors.disabledText
          : widget.activedColor, //widget.activedColor,
    );
  }
}
