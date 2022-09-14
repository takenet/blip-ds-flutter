import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path_utils;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:blip_ds/blip_ds.dart';

abstract class DSFileService {
  static Future<void> open(
    final String fileName,
    final String url, {
    void Function(bool)? onDownloadStateChange,
  }) async {
    final path = await download(url, fileName);
    if (path?.isEmpty ?? true) {
      return;
    }

    final result = await OpenFilex.open(path);

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

  static Future<String?> download(
    final String url,
    final String fileName, {
    final String? path,
    final void Function(bool)? onDownloadStateChange,
  }) async {
    if (onDownloadStateChange != null) onDownloadStateChange.call(true);
    try {
      final savedFilePath = path_utils.join(
          path ?? (await getTemporaryDirectory()).path, fileName);

      if (await io.File(savedFilePath).exists()) {
        return savedFilePath;
      }

      final response = await Dio().download(url, savedFilePath);

      if (response.statusCode == 200) return savedFilePath;
    } catch (e) {
      _showAlert('Erro', 'Download indisponível');
    } finally {
      if (onDownloadStateChange != null) onDownloadStateChange.call(false);
    }

    return null;
  }

  //TODO: Use the DS's widget when avalible and question the PD about it
  static void _showAlert(
    final String title,
    final String message,
  ) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: DSColors.neutralLightSnow);
  }
}
