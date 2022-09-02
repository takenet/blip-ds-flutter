import 'package:get/get.dart';

class DSTextMessageBubbleController extends GetxController {
  final shouldShowFullText = RxBool(false);

  void showMoreOnTap() {
    shouldShowFullText.value = true;
  }
}
