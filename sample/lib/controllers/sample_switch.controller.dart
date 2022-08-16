import 'package:get/get.dart';

/// GetX Controller for holding Switch's current value
class SampleSwitchController extends GetxController {
  SampleSwitchController();

  RxBool onSwitch = true.obs;
  RxBool onSwitchTile = true.obs;
  RxBool onSwitchTileDisabled = true.obs;

  /// Swap true/false & save it to observable
  void toggleSwitch() => onSwitch.value = !onSwitch.value;
  void toggleSwitchTile() => onSwitchTile.value = !onSwitchTile.value;
}
