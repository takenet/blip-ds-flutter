import 'package:filesize/filesize.dart';
import 'package:get/get.dart';

import 'package:blip_ds/src/services/ds_file.service.dart';

class DSFileMessageBubbleController extends GetxController {
  final isDownloading = RxBool(false);

  String getFileSize(final int size) {
    return filesize(size, 1);
  }

  Future<void> openFile(
    final String filename,
    final String url,
  ) =>
      DSFileService.open(
        filename,
        url,
        onDownloadStateChange: (loading) => isDownloading.value = loading,
      );
}
