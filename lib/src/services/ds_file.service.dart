import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path_utils;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class DSFileService {
  static Future<void> open(
    final String filename,
    final String url, {
    final void Function(bool)? onDownloadStateChange,
    final Map<String, String?>? httpHeaders,
  }) async {
    final path = await download(
      url,
      filename,
      onDownloadStateChange: onDownloadStateChange,
      httpHeaders: httpHeaders,
    );

    if (path?.isEmpty ?? true) {
      return;
    }

    final result = await OpenFilex.open(path);

    switch (result.type) {
      case ResultType.done:
        break;
      case ResultType.noAppToOpen:
        launchUrlString(
          url,
          mode: LaunchMode.externalApplication,
        );
        break;
      default:
        throw Exception(result.message);
    }
  }

  static Future<String?> download(
    final String url,
    final String filename, {
    final String? path,
    final void Function(bool)? onDownloadStateChange,
    final Map<String, String?>? httpHeaders,
  }) async {
    try {
      onDownloadStateChange?.call(true);
      final savedFilePath = path_utils.join(
          path ?? (await getTemporaryDirectory()).path, filename);

      if (await File(savedFilePath).exists()) {
        return savedFilePath;
      }

      final response = await Dio().download(
        url,
        savedFilePath,
        options: Options(
          headers: httpHeaders,
        ),
      );

      if (response.statusCode == 200) return savedFilePath;
    } finally {
      onDownloadStateChange?.call(false);
    }

    return null;
  }

  static String getFileExtensionFromMime(String? mimeType) =>
      extensionFromMime(mimeType ?? '');
}
