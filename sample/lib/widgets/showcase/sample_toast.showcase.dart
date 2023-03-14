import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleToastShowcase extends StatelessWidget {
  const SampleToastShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toastProps = DSToastProps(
      title: 'Título do toast',
      message:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sed blandit ex. ',
    );

    final toastActionProps = DSToastProps(
      title: 'Título do toast com action',
      message: 'Lorem ipsum dolor sit amet, consectetur adipisci elit.',
      actionType: DSToastActionType.button,
      buttonText: 'Action',
      onPressedButton: () => debugPrint('FECHOU'),
    );

    final toastPersistentProps = DSToastProps(
      title: 'Persistent Toast',
      message:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sed blandit ex. Vivamus eget molestie urna. ',
      toastDuration: 0,
    );

    final toastNoTitleProps = DSToastProps(
      message:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sed blandit ex. Vivamus eget molestie urna. ',
      positionOffset: 100.0,
    );

    return Column(
      children: [
        DSBodyText('Toasts'),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => DSToastService.success(toastActionProps),
              label: 'Success',
            ),
            DSPrimaryButton(
              onPressed: () => DSToastService.notification(toastProps),
              label: 'Notification',
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => DSToastService.system(toastProps),
              label: 'System',
            ),
            DSPrimaryButton(
              onPressed: () => DSToastService.error(toastProps),
              label: 'Error',
            ),
            DSPrimaryButton(
              onPressed: () => DSToastService.warning(toastProps),
              label: 'Warning',
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => DSToastService.system(toastPersistentProps),
              label: 'System persistent toast',
            ),
            DSPrimaryButton(
              onPressed: () => DSToastService.system(toastNoTitleProps),
              label: 'No title',
            ),
          ],
        ),
      ],
    );
  }
}
