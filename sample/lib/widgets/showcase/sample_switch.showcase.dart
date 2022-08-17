import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/sample_switch.controller.dart';

class SampleSwitchShowcase extends StatelessWidget {
  const SampleSwitchShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SampleSwitchController controller = Get.put(SampleSwitchController());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Obx(
          () => DSSwitchTile(
            value: controller.onSwitchTile.value,
            onChanged: (value) => controller.toggleSwitchTile(),
            title: DSBodyText(
              text: 'Label switch',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => DSSwitchTile(
            isEnabled: false,
            value: controller.onSwitchTileDisabled.value,
            onChanged: (value) => controller.onSwitchTileDisabled,
            title: DSBodyText(
              text: 'Label switch',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => DSSwitch(
            onChanged: (value) => controller.toggleSwitch(),
            value: controller.onSwitch.value,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
