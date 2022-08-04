import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleSwitchShowcase extends StatelessWidget {
  const SampleSwitchShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSSwitchButton(),
      ],
    );
  }
}
