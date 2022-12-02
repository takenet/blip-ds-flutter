import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

class SampleToastShowcase extends StatelessWidget {
  const SampleToastShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toast = DSToastService(
      title: 'Título do toast',
      message:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sed blandit ex. ',
      toastDuration: 3000,
    );

    final toastAction = DSToastService(
      title: 'Título do toast com action',
      message: 'Lorem ipsum dolor sit amet, consectetur adipisci elit.',
      actionType: DSToastActionType.button,
      buttonText: 'Action',
      onPressedButton: () => print('FECHOU'),
      toastDuration: 2000,
    );

    final toastPersistent = DSToastService(
      title: 'Título do toast',
      message:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sed blandit ex. Vivamus eget molestie urna. ',
      toastDuration: 0,
    );

    final toastNoTitle = DSToastService(
      message:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sed blandit ex. Vivamus eget molestie urna. ',
      positionOffset: 100.0,
      toastDuration: 3000,
    );

    return Column(
      children: [
        DSBodyText('Toasts'),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => toastAction.success(),
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
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => toastPersistent.system(),
              label: 'System persistent toast',
            ),
            DSPrimaryButton(
              onPressed: () => toastNoTitle.system(),
              label: 'No title',
            ),
          ],
        ),
      ],
    );
  }
}
