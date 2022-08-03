import 'dart:io' as io;
import 'package:blip_ds/blip_ds.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:filesize/filesize.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:path/path.dart' as path_utils;

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

  void openFile(final String filename, final String url) async {
    final String directory = (await getTemporaryDirectory()).path;
    final String savedFilePath = path_utils.join(directory, filename);

    if (!await io.File(savedFilePath).exists()) {
      final response = await _downloadFile(url, savedFilePath);
      if (response == null) {
        return;
      }
    }

    final result = await OpenFilex.open(savedFilePath);

    switch (result.type) {
      case ResultType.done:
        break;
      case ResultType.noAppToOpen:
        launchUrlString(url, mode: LaunchMode.externalApplication);
        break;
      default:
        _showAlert('Erro', 'Visualização indisponível');
    }
  }

  Future<dynamic> _downloadFile(
      final String url, final String savedFilePath) async {
    isDownloading.value = true;
    try {
      return await Dio().download(url, savedFilePath);
    } catch (e) {
      _showAlert('Erro', 'Download indisponível');
    } finally {
      isDownloading.value = false;
    }
  }

  //TODO: Use the DS's widget when avalible and question the PD about it
  void _showAlert(final String title, final String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: DSColors.neutralLightSnow);
  }
}
