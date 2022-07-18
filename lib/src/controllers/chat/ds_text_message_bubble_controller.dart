import 'package:get/get.dart';

class DSTextMessageBubbleController extends GetxController {
  final showFullText = RxBool(false);

  void showMoreOnTap() {
    showFullText.value = true;
  }
}
