import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleDialogShowcase extends StatelessWidget {
  const SampleDialogShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialog = DSDialog(
      title: 'title',
      text: 'text',
      firstButtonText: 'First',
      secondButtonText: 'Second',
      firstButtonPressed: () => Navigator.of(context).pop(),
      secondButtonPressed: () => Navigator.of(context).pop(),
      context: context,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: ElevatedButton(
            onPressed: () => dialog.system(),
            child: const Text('System dialog'),
          ),
        ),
        Flexible(
          child: ElevatedButton(
            onPressed: () => dialog.error(),
            child: const Text('Error dialog'),
          ),
        ),
        Flexible(
          child: ElevatedButton(
            onPressed: () => dialog.warning(),
            child: const Text('System warning'),
          ),
        ),
      ],
    );
  }
}
