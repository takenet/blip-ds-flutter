import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path_utils;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class DSFileService {
  static Future<void> open({
    required final String url,
    final String? path,
    final void Function(bool)? onDownloadStateChange,
    final Map<String, String?>? httpHeaders,
  }) async {
    final filePath = await download(
      url: url,
      path: path,
      onDownloadStateChange: onDownloadStateChange,
      httpHeaders: httpHeaders,
    );

    if (filePath?.isEmpty ?? true) {
      return;
    }

    final result = await OpenFilex.open(filePath);

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

  static Future<String?> download({
    required final String url,
    final String? path,
    final void Function(bool)? onDownloadStateChange,
    final Map<String, String?>? httpHeaders,
    final Function(int, int)? onReceiveProgress,
  }) async {
    try {
      onDownloadStateChange?.call(true);

      var savedFilePath = path ??
          path_utils.join(
            (await getTemporaryDirectory()).path,
            DateTime.now().toIso8601String().replaceAll('.', ''),
          );

      if (File(savedFilePath).existsSync()) {
        return savedFilePath;
      }

      final response = await Dio().download(
        url,
        savedFilePath,
        options: Options(
          headers: httpHeaders,
        ),
        onReceiveProgress: onReceiveProgress != null
            ? (currentProgress, maximumProgress) =>
                onReceiveProgress(currentProgress, maximumProgress)
            : null,
      );

      if (response.statusCode == 200) {
        final hasExtension = path_utils.extension(savedFilePath).isNotEmpty;

        if (!hasExtension) {
          final newExtension = getFileExtensionFromMime(
            response.headers.map['content-type']?.first,
          );

          if (newExtension.isNotEmpty) {
            final filename = savedFilePath.substring(0);

            final newFilePath = '$filename.$newExtension';

            File(savedFilePath).renameSync(newFilePath);
            savedFilePath = newFilePath;
          }
        }

        return savedFilePath;
      }
    } finally {
      onDownloadStateChange?.call(false);
    }

    return null;
  }

  static String getFileExtensionFromMime(String? mimeType) =>
      extensionFromMime(mimeType ?? '');
}
