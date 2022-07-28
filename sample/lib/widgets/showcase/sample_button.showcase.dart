import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleButtonShowcase extends StatelessWidget {
  const SampleButtonShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSPrimaryButton(
          onPressed: () => {},
          label: 'Primary Button',
          leadingIcon: const Icon(
            Icons.info_outline,
            size: 20,
          ),
          trailingIcon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          // disable: true,
          // loading: true,
        ),
        DSSecondaryButton(
          onPressed: () => {},
          label: 'Secondary Button',
          leadingIcon: const Icon(
            Icons.info_outline,
            size: 20,
          ),
          trailingIcon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          // disable: true,
          // loading: true,
        ),
        DSTertiaryButton(
          onPressed: () => {},
          label: 'Tertiary Button',
          leadingIcon: const Icon(
            Icons.info_outline,
            size: 20,
          ),
          trailingIcon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          // disable: true,
          // loading: true,
        ),
      ],
    );
  }
}
