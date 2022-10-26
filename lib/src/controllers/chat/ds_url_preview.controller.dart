import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:simple_link_preview/simple_link_preview.dart';

/// A Design System's controller related to [DSUrlPreview] widget.
class DSUrlPreviewController extends GetxController {
  final isLoading = RxBool(false);
  final urlPreview = Rx<LinkPreview?>(null);

  DSUrlPreviewController(Uri url) {
    getUrlPreview(url);
  }

  Future<void> getUrlPreview(final Uri url) async {
    if (url.toString().isNotEmpty) {
      try {
        if (await _isValidUrl(url)) {
          isLoading.value = true;

          urlPreview.value = await SimpleLinkPreview.getPreview(url.toString());
        } else {
          urlPreview.value = null;
        }
      } catch (_) {
        urlPreview.value = null;
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<bool> _isValidUrl(final Uri url) async {
    final response = await Dio().headUri(url);
    return response.statusCode == 200;
  }
}
