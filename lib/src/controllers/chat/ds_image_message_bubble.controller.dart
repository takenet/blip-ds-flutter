import 'package:get/get.dart';

class DSImageMessageBubbleController extends GetxController {
  final error = RxBool(false);

  void setError() {
    error.value = true;
  }
}
