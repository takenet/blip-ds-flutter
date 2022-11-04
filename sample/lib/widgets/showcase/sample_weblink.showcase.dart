import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleWeblinkShowcase extends StatelessWidget {
  const SampleWeblinkShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSWeblink(
          title: 'Take Blip',
          text:
              'Atenda de forma inteligente, no canal digital que seu cliente prefere',
          url: 'https://www.take.net/',
          align: DSAlign.right,
        ),
        DSWeblink(
          title: 'Take Blip',
          text:
              'Atenda de forma inteligente, no canal digital que seu cliente prefere',
          url: 'https://www.take.net/',
          align: DSAlign.left,
        ),
      ],
    );
  }
}
