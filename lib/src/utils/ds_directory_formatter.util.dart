import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../enums/ds_file_type.enum.dart';

abstract class DSDirectoryFormatter {
  static Future<String> formatMediaDirectory({
    required String filePath,
    required DSFileType type,
    required String fileName,
  }) async {
    String directory = path.dirname(filePath);
    final String formattedDir = await _formatDirectory(type: type, directory: directory);
    String newName = path.join(formattedDir, fileName);
    await File(filePath).rename(newName);
    return newName;
  }

  static Future<String> getPath({required DSFileType type}) async {
    final temporaryPath = (await getTemporaryDirectory()).path;
    final mediaPath = _formatDirectory(type: type, directory: temporaryPath);
    return mediaPath;
  }

  static Future<String> _formatDirectory(
      {required DSFileType type, required String directory}) async {
    final formattedDirectory = directory.replaceAll(
      directory.split('/').last,
      'BlipDesk/Media/${type.name.capitalizeFirst}',
    );
    final dirExists = await Directory(formattedDirectory).exists();
    if (!dirExists) {
      await Directory(formattedDirectory).create(recursive: true);
    }
    return formattedDirectory;
  }
}
