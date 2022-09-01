import 'package:get/get_rx/get_rx.dart';

/// GetX Controller for holding Radios's current value
class SampleRadioController {
  SampleRadioController() {
    String selected = optionsString.first;

    selectedRadio.value = selected;
    selectedRadioDisabled.value = selected;
    selectedRadioTile.value = selected;
    selectedRadioTileDisabled.value = selected;
    selectedOption.value = selected;
  }

  final List<String> optionsString = ["Option 1", "Option 2"];

  final selectedRadio = RxString("");
  final selectedRadioDisabled = RxString("");
  final selectedRadioTile = RxString("");
  final selectedRadioTileDisabled = RxString("");
  final selectedOption = RxString("");
}
