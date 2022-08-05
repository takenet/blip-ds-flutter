import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSSwitch extends StatelessWidget {
  final String text;

  const DSSwitch({
    Key? key,
    this.text = 'dfsgdfgdfg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        DSSwitchButton(),
      ],
    );
  }
}
