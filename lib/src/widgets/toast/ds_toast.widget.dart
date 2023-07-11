import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../enums/ds_toast_action_type.enum.dart';
import '../../enums/ds_toast_type.enum.dart';
import '../../models/ds_toast_props.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_utils.util.dart';
import '../buttons/ds_icon_button.widget.dart';
import '../buttons/ds_tertiary_button.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_headline_small_text.widget.dart';

class DSToast extends StatefulWidget {
  /// A Design System's [DSToast] widget.
  const DSToast({
    super.key,
    required this.props,
    required this.onClose,
  });

  /// A property of type [DSToastProps] used to configure the toast.
  final DSToastProps props;

  /// A function called when the toast is closed
  final void Function(DSToast) onClose;

  @override
  State<StatefulWidget> createState() => _DSToastState();
}

class _DSToastState extends State<DSToast> with AutomaticKeepAliveClientMixin {
  /// Icon widget to show
  Widget? icon;

  /// Color of elements in toast
  Color? backgroundColor;

  /// Animation scene controller
  Control? _controlAnimation = Control.stop;

  /// Toast state manager to be recreated when closing
  StateSetter? state;

  /// Timer to keep toast on screen
  Timer? _timeToastDuration;

  DSToastProps get props => widget.props;

  @override
  void initState() {
    super.initState();

    _prepareToast();
    start();
  }

  void close() {
    widget.onClose(widget);
    _stopTimer();
  }

  void _stopTimer() {
    if (_timeToastDuration != null) {
      _timeToastDuration!.cancel();
      _timeToastDuration = null;
    }
  }

  void start() {
    _controlAnimation = Control.playFromStart;
  }

  void stop() {
    _controlAnimation = Control.stop;
  }

  /// Prepares the presentation of toast elements according to the type
  void _prepareToast() {
    switch (props.type) {
      case DSToastType.warning:
        backgroundColor = DSColors.primaryYellowsCorn;
        icon = _setIcon(DSIcons.warning_outline);
        break;
      case DSToastType.error:
        backgroundColor = DSColors.extendRedsFlower;
        icon = _setIcon(DSIcons.error_outline);
        break;
      case DSToastType.system:
        backgroundColor = DSColors.illustrationBlueGenie;
        icon = _setIcon(DSIcons.message_ballon_outline);
        break;
      case DSToastType.notification:
        backgroundColor = Colors.transparent;
        icon = _setIcon(DSIcons.bell_outline);
        break;
      default:
        backgroundColor = DSColors.primaryGreensMint;
        icon = _setIcon(DSIcons.like_outline);
    }
  }

  Widget _setIcon(final IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Icon(
        icon,
        color: DSColors.neutralDarkCity,
        size: 24.0,
      ),
    );
  }

  /// Create the toast card
  Material _cardToast() {
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(8.0),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            left: -30.0,
            top: -10.0,
            child: SvgPicture.asset(
              'assets/images/blip_balloon.svg',
              package: DSUtils.packageName,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (icon != null) icon!,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (props.title != null)
                              DSHeadlineSmallText(
                                props.title,
                                overflow: TextOverflow.visible,
                              ),
                            if (props.message != null)
                              DSBodyText(
                                props.message,
                                overflow: TextOverflow.visible,
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (props.actionType == DSToastActionType.icon)
                      DSIconButton(
                        size: 40.0,
                        icon: const Icon(DSIcons.close_outline),
                        onPressed: () => state!(_closeToast),
                      ),
                  ],
                ),
                if (props.actionType == DSToastActionType.button)
                  DSTertiaryButton(
                    label: props.buttonText,
                    onPressed: () {
                      props.onPressedButton!();
                      state!(_closeToast);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Create and manage the toast animation
  @override
  Widget build(BuildContext context) {
    super.build(context);

    double start = (MediaQuery.of(Get.context!).size.width) * -1.0;
    double end = 0.0;

    final duration = props.toastDuration ??
        ((props.message?.length ?? 0) * 100 + (props.title?.length ?? 0) * 100);

    return Dismissible(
      key: widget.key!,
      onDismissed: (direction) {
        stop();
        close();
      },
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
          state = mystate;
          const defaultPadding = 16.0;

          return CustomAnimationBuilder<double>(
            duration: DSUtils.defaultAnimationDuration,
            control: _controlAnimation!,
            tween: Tween(begin: start, end: end),
            builder: (_, value, child) {
              return Transform.translate(
                offset: Offset(value, 0.0),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                defaultPadding,
                0,
                defaultPadding,
                defaultPadding,
              ),
              child: _cardToast(),
            ),
            onCompleted: () async {
              if (props.toastDuration == 0) {
                if (_controlAnimation == Control.playReverse) {
                  close();
                }
              } else {
                if (_controlAnimation == Control.playFromStart) {
                  _timeToastDuration = Timer(
                    Duration(milliseconds: duration),
                    () {
                      state!(
                        () {
                          _controlAnimation = Control.playReverse;
                        },
                      );
                    },
                  );
                } else {
                  close();
                }
              }
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _closeToast() {
    _stopTimer();
    _controlAnimation = Control.playReverse;
  }
}
