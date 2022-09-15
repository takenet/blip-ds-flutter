import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

const size = 44.0;

class DSSendButton extends SizedBox {
  DSSendButton({
    super.key,
    required void Function() onPressed,
  }) : super(
          height: size,
          width: size,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              backgroundColor: DSColors.primaryNight,
              foregroundColor: DSColors.primaryLight,
            ),
            child: Image.asset(
              'assets/images/send_button.png',
              package: DSUtils.packageName,
            ),
          ),
        );
}
