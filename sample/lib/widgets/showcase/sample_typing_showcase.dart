import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleTypingShowcase extends StatelessWidget {
  const SampleTypingShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DSTypingMessageBubble(
          align: DSAlign.left,
        ),
        DSTypingMessageBubble(
          align: DSAlign.right,
        ),
      ],
    );
  }
}