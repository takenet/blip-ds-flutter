import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/ds_message_item.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../utils/ds_utils.util.dart';

class DSReplySwipe extends StatefulWidget {
  const DSReplySwipe({
    super.key,
    required this.child,
    required this.message,
    this.onReply,
  });

  final DSMessageItem message;
  final Widget child;
  final void Function(DSMessageItem)? onReply;

  @override
  State<DSReplySwipe> createState() => _DSReplySwipeState();
}

class _DSReplySwipeState extends State<DSReplySwipe> {
  final progress = ValueNotifier<double>(0.0);

  bool endReached = false;

  @override
  void dispose() {
    progress.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onUpdate: (details) {
        progress.value = details.progress;
      },
      direction: DismissDirection.startToEnd,
      dismissThresholds: {
        DismissDirection.startToEnd: double.infinity,
      },
      confirmDismiss: (_) async {
        return false;
      },
      background: ValueListenableBuilder(
        valueListenable: progress,
        builder: (context, swipeProgress, _) {
          final paddingProgress = clampDouble(swipeProgress * 3.5, 0, 1);
          final opacityProgress = clampDouble(swipeProgress * 2.5, 0, 1);

          if (!endReached && paddingProgress == 1) {
            endReached = true;

            HapticFeedback.lightImpact();

            widget.onReply?.call(widget.message);
          } else if (paddingProgress <= .8) {
            endReached = false;
          }

          return AnimatedSize(
            duration: DSUtils.defaultAnimationDuration,
            child: AnimatedOpacity(
              duration: DSUtils.defaultAnimationDuration,
              opacity: opacityProgress,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.lerp(
                      EdgeInsets.zero,
                      EdgeInsets.symmetric(horizontal: 40.0),
                      paddingProgress,
                    )!,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: DSColors.contentDisable,
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.reply,
                        color: DSColors.neutralLightSnow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      child: widget.child,
    );
  }
}
