import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:simple_link_preview/simple_link_preview.dart';

class DSUrlPreviewController extends GetxController {
  final isLoading = RxBool(false);
  final urlPreview = Rx<LinkPreview?>(null);

  Future<void> getUrlPreview(Uri url) async {
    if (url.toString().isNotEmpty) {
      try {
        final response = await Dio().headUri(url);

        if (response.statusCode == 200) {
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
}
