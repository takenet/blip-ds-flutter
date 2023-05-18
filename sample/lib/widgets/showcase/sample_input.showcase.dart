import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleInputShowcase extends StatelessWidget {
  const SampleInputShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Wrap(
        runSpacing: 8.0,
        children: [
          DSPhoneInput(),
          DSSearchInput(
            onClear: () {},
            onSearch: (_) {},
          ),
        ],
      ),
    );
  }
}
