import 'package:filesize/filesize.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path_utils;

import 'package:blip_ds/src/services/ds_file.service.dart';

class DSFileMessageBubbleController extends GetxController {
  final isDownloading = RxBool(false);

  String getFileSize(final int size) {
    return filesize(size, 1);
  }

  String getAsset(final String filename) {
    const String path = 'assets/images';
    final String extension = path_utils.extension(filename).isNotEmpty
        ? path_utils.extension(filename).substring(1)
        : '';

    return path_utils.join(path,
        'file-${extension.length > 3 ? extension.substring(0, 3) : extension}.png');
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
