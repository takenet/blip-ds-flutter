import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sample/controllers/sample_radio.controller.dart';

enum SingingCharacter { lafayette, jefferson }

class SampleRadioShowcase extends StatelessWidget {
  SampleRadioShowcase({Key? key}) : super(key: key);

  final SampleRadioController _controller = Get.put(SampleRadioController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                () => DSBodyText(
                  "Opção selecionada: ${_controller.selectedOption.value}",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              _radioString(
                index: 0,
              ),
              const SizedBox(width: 10),
              _radioString(
                index: 1,
              ),
              const SizedBox(width: 30),
              _radioString(
                index: 0,
                isEnabled: false,
              ),
              const SizedBox(width: 10),
              _radioString(
                index: 1,
                isEnabled: false,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              _radioTileString(
                index: 0,
              ),
              const SizedBox(width: 10),
              _radioTileString(
                index: 1,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              _radioTileString(
                index: 0,
                isEnabled: false,
              ),
              const SizedBox(width: 10),
              _radioTileString(
                index: 1,
                isEnabled: false,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  _radioString({int index = 0, bool isEnabled = true}) {
    return Obx(
      () => DSRadio<String>(
        isEnabled: isEnabled,
        value: _controller.optionsString[index],
        groupValue: isEnabled
            ? _controller.selectedRadio.value
            : _controller.selectedRadioDisabled.value,
        onChanged: (value) {
          if (isEnabled) _controller.selectedRadio.value = value!;
          _controller.selectedOption.value = value!;
        },
      ),
    );
  }

  _radioTileString({int index = 0, bool isEnabled = true}) {
    return Obx(
      () => DSRadioTile<String>(
        title: DSBodyText(_controller.optionsString[index]),
        value: _controller.optionsString[index],
        groupValue: isEnabled
            ? _controller.selectedRadioTile.value
            : _controller.selectedRadioTileDisabled.value,
        isEnabled: isEnabled,
        onChanged: (value) {
          if (isEnabled) _controller.selectedRadioTile.value = value = value!;
          _controller.selectedOption.value = value!;
        },
      ),
    );
  }
}
