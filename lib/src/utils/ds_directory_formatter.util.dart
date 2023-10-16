import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

abstract class DSDirectoryFormatter {
  static Future<String> getPath({
    required final String type,
    required final String fileName,
  }) async {
    final temporaryPath = (await getTemporaryDirectory()).path;

    final typeFolder = '${type.split('/').first.capitalizeFirst}';
    final extension = type.split('/').last;

    final typePrefix = '${typeFolder.substring(0, 3).toUpperCase()}-';

    final newFileName =
        '${!fileName.startsWith(typePrefix) ? typePrefix : ''}$fileName';

    final path = await _formatDirectory(
      type: typeFolder,
      directory: temporaryPath,
    );

    return '$path/$newFileName.$extension';
  }

  static Future<String> _formatDirectory({
    required final String type,
    required final String directory,
  }) async {
    final formattedDirectory = directory.replaceAll(
      directory.split('/').last,
      'Blip Desk/Media/$type',
    );

    final directoryExists = await Directory(formattedDirectory).exists();

    if (!directoryExists) {
      await Directory(formattedDirectory).create(recursive: true);
    }

    return formattedDirectory;
  }
}
