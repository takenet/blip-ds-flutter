import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleTypingShowcase extends StatelessWidget {
  const SampleTypingShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DSTypingAnimationMessageBubble(
          align: DSAlign.left,
        ),
        DSTypingAnimationMessageBubble(
          align: DSAlign.right,
        ),
        DSDotAnimation(
          color: Colors.red,
          size: 15,
          innerPadding: 10,
        ),
      ],
    );
  }
}
