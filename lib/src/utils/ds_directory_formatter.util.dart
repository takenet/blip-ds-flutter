import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

abstract class DSDirectoryFormatter {
  static Future<String> getPath({
    required final String type,
    required final String fileName,
  }) async {
    final String? temporaryPath = Platform.isAndroid
        ? (await getExternalCacheDirectories())?.first.path
        : (await getApplicationCacheDirectory()).path;
    final typeName = '${type.split('/').first.capitalizeFirst}';
    final prefix = fileName.contains(typeName.substring(0, 3).toUpperCase())
        ? ''
        : '${typeName.substring(0, 3).toUpperCase()}-';
    final extension = type.split('/').last;
    final path =
        await _formatDirectory(typeName: typeName, directory: temporaryPath!);
    final fullPath = '$path/$prefix$fileName.$extension';
    return fullPath;
  }

  static Future<String> _formatDirectory(
      {required String typeName, required String directory}) async {
    final formattedDirectory = '$directory/$typeName';
    final directoryExists = await Directory(formattedDirectory).exists();

    if (!directoryExists) {
      await Directory(formattedDirectory).create(recursive: true);
    }

    return formattedDirectory;
  }
}
