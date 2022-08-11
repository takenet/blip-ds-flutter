import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleDialogShowcase extends StatelessWidget {
  const SampleDialogShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialog = DSDialog(
      title: 'title',
      text: 'text',
      firstButton: DSPrimaryButton(
        onPressed: (() => Navigator.of(context).pop()),
        label: 'firstButton',
      ),
      secondButton: DSSecondaryButton(
        onPressed: (() => Navigator.of(context).pop()),
        label: 'secondButton',
      ),
      context: context,
    );

    return Column(
      children: [
        DSBodyText(text: 'Dialogs'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => dialog.system(),
              label: 'System',
            ),
            DSPrimaryButton(
              onPressed: () => dialog.error(),
              label: 'Error',
            ),
            DSPrimaryButton(
              onPressed: () => dialog.warning(),
              label: 'Warning',
            ),
          ],
        ),
      ],
    );
  }
}
