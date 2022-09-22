import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

class SampleToastShowcase extends StatelessWidget {
  const SampleToastShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toast = DSToastService(
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
        DSBodyText(text: 'Toasts'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => toast.success(),
              label: 'Success',
            ),
            DSPrimaryButton(
              onPressed: () => toast.notification(),
              label: 'Notification',
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => toast.system(),
              label: 'System',
            ),
            DSPrimaryButton(
              onPressed: () => toast.error(),
              label: 'Error',
            ),
            DSPrimaryButton(
              onPressed: () => toast.warning(),
              label: 'Warning',
            ),
          ],
        ),
      ],
    );
  }
}
