import 'package:get/get.dart';

class DSImageMessageBubbleController extends GetxController {
  final error = RxBool(false);
  final appBarVisible = RxBool(false);

  void setError() {
    error.value = true;
  }

  void showAppBar() {
    appBarVisible.value
        ? appBarVisible.value = false
        : appBarVisible.value = true;
  }
}
