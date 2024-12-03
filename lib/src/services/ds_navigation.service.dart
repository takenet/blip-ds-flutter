import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'ds_context.service.dart';

abstract class NavigationService {
  static void pop<T>([T? result]) {
    try {
      Get.back(result: result);
    } catch (e) {
      Navigator.of(DSContextService.context!).pop(result);
    }
  }
}
