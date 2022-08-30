import 'package:get/get_rx/get_rx.dart';

/// GetX Controller for holding Radios's current value
class SampleRadioController {
  final List<String> optionsString = ["Option 1", "Option 2"];

  RxString selectedRadio = "Option 1".obs;
  RxString selectedRadioDisabled = "Option 1".obs;

  RxString selectedRadioTile = "Option 1".obs;
  RxString selectedRadioTileDisabled = "Option 1".obs;

  RxString selectedOption = "".obs;
}
