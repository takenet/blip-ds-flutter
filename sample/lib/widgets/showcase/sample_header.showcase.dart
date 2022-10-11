import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleHeaderShowcase extends StatelessWidget {
  const SampleHeaderShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSHeader(
          title: 'Blip Design System ',
          subtitle: 'Showcase',
          canPop: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: DSPrimaryButton(onPressed: null, label: 'Teste'),
            )
          ],
        ),
        const DSHeader(
          title: 'Blip Design System ',
          subtitle: 'Showcase',
          customerName: 'Andre Rossi',
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.filter_alt_rounded,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
