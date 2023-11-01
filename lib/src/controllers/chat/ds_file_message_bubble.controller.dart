import 'package:file_sizes/file_sizes.dart';
import 'package:get/get.dart';

import '../../services/ds_file.service.dart';

class DSFileMessageBubbleController extends GetxController {
  final isDownloading = RxBool(false);

  String getFileSize(final int size) {
    return size > 0
        ? FileSize.getSize(
            size,
            precision: PrecisionValue.One,
          )
        : '';
  }

  Future<void> openFile({
    required final String url,
    final Map<String, String?>? httpHeaders,
  }) =>
      DSFileService.open(
        url: url,
        onDownloadStateChange: (loading) => isDownloading.value = loading,
        httpHeaders: httpHeaders,
      );
}
