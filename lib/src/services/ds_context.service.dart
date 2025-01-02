import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class DSContextService {
  static BuildContext? _context = Get.context;
  static BuildContext? _overlayContext = Get.overlayContext;

  static init(
    final BuildContext context, [
    final BuildContext? overlayContext,
  ]) {
    _context = context;
    _overlayContext = overlayContext;
  }

  static BuildContext? get context => _context;
  static BuildContext? get overlayContext => _overlayContext ?? _context;
}
