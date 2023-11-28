import 'package:get/get.dart';

extension FutureExtension on Future {
  Future<dynamic> trueWhile<T>(Rx<bool> rxValue) {
    rxValue.value = true;

    return whenComplete(
      () => rxValue.value = false,
    );
  }
}
