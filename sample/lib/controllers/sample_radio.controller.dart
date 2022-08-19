import 'package:get/get_state_manager/get_state_manager.dart';

/// GetX Controller for holding Radios's current value
class SampleRadioController extends GetxController {
  final List<String> optionsString = ["Option 1", "Option 2"];

  String selectedRadio = "Option 1";
  String selectedRadioDisabled = "Option 1";

  String selectedRadioTile = "Option 1";
  String selectedRadioTileDisabled = "Option 1";

  String selectedOption = "";

  void onClickRadio(value) {
    selectedOption = value;
    update();
  }
}
