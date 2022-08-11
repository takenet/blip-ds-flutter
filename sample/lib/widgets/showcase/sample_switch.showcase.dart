import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleSwitchShowcase extends StatefulWidget {
  const SampleSwitchShowcase({
    Key? key,
  }) : super(key: key);

  @override
  SampleSwitchShowcaseState createState() => SampleSwitchShowcaseState();
}

class SampleSwitchShowcaseState extends State<SampleSwitchShowcase> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        DSSwitchTile(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
          title: DSBodyText(
            text: 'Cupertino Switch dfzgs dfgsd fgsdfg sdfg',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 20),
        DSSwitch(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
