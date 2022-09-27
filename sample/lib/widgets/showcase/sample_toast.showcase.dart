import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

class SampleToastShowcase extends StatelessWidget {
  const SampleToastShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toast = DSToastService(
      title: 'Título do toast',
      text:
          'Lorem ipsum dolor sit amet, consectetur adipisci elit sdfgs dfgs ddfgsdfg sdfg sdfgs df sdfg sdf asdfg asdfas dfasdf asdf asdf',
      context: context,
    );

    final toastAction = DSToastService(
      title: 'Título do toast com action',
      text:
          'Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor esdfa sdfas dasgdrf dfsh sdfgh df',
      actionType: DSActionType.button,
      buttonText: 'Action',
      onPressedButton: () => Navigator.pop(context),
      context: context,
    );

    return Column(
      children: [
        DSBodyText(text: 'Toasts'),
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
      ],
    );
  }
}
