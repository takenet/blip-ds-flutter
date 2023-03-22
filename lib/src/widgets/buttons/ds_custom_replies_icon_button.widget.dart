import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSCustomRepliesIconButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isVisible;

  const DSCustomRepliesIconButton({
    super.key,
    required this.onPressed,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) => Visibility(
        visible: isVisible,
        child: DSIconButton(
          onPressed: onPressed,
          icon: const Icon(
            DSIcons.message_talk_outline,
            color: DSColors.neutralDarkRooftop,
          ),
        ),
      );
}
