import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleDialogShowcase extends StatelessWidget {
  const SampleDialogShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialog = DSDialogService(
      title: 'title',
      text: 'text',
      primaryButton: DSPrimaryButton(
        onPressed: (() => Navigator.of(context).pop()),
        label: 'firstButton',
      ),
      secondaryButton: DSSecondaryButton(
        onPressed: (() => Navigator.of(context).pop()),
        label: 'secondButton',
      ),
      context: context,
    );

    return Column(
      children: [
        DSBodyText('Dialogs'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => dialog.showSystem(),
              label: 'System',
            ),
            DSPrimaryButton(
              onPressed: () => dialog.showError(),
              label: 'Error',
            ),
            DSPrimaryButton(
              onPressed: () => dialog.showWarning(),
              label: 'Warning',
            ),
          ],
        ),
      ],
    );
  }
}
