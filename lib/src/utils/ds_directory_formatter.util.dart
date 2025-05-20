import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

abstract class DSDirectoryFormatter {
  static Future<String> getCachePath({
    required final String type,
    required final String filename,
    String extension = '',
  }) async {
    final cachePath = (await getApplicationCacheDirectory()).path;

    final typeComponents = type.split('/');

    final typeFolder = '${typeComponents.first.capitalizeFirst}';

    if (extension.isNotEmpty) {
      extension = '.$extension';
    } else if (typeComponents.length > 1) {
      extension = '.${typeComponents.last}';
    }

    final typePrefix = '${typeFolder.substring(0, 3).toUpperCase()}-';

    final newFileName =
        '${!filename.startsWith(typePrefix) ? typePrefix : ''}$filename';

    final path = await _formatDirectory(
      type: typeFolder,
      directory: cachePath,
    );

    return '$path/$newFileName$extension';
  }

  static Future<String> _formatDirectory({
    required final String type,
    required final String directory,
  }) async {
    final formattedDirectory = '$directory/$type';
    final directoryExists = await Directory(formattedDirectory).exists();

    if (!directoryExists) {
      await Directory(formattedDirectory).create(recursive: true);
    }

    return formattedDirectory;
  }
}
