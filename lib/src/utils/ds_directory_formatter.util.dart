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
    final String formattedDirectory =
        await _formatDirectory(type: type, directory: directory);
    final String newName = await _formatNewName(
      formattedDirectory: formattedDirectory,
      fileName: fileName,
      filePath: filePath,
    );
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
      'Blip Desk/Media/${type.name.capitalizeFirst}',
    );
    final directoryExists = await Directory(formattedDirectory).exists();
    if (!directoryExists) {
      await Directory(formattedDirectory).create(recursive: true);
    }
    return formattedDirectory;
  }

  static Future<String> _formatNewName({
    required String formattedDirectory,
    required String fileName,
    required String filePath,
  }) async {
    int numberOfFiles = 0;
    final String extension = filePath.split('.').last;
    final directory = Directory(formattedDirectory).listSync();

    for (FileSystemEntity files in directory) {
      if (files.path.contains(fileName) &&
          (files.path.split('.').last == extension)) {
        numberOfFiles++;
      }
    }

    String newName =
        '${path.join(formattedDirectory, fileName)}-BA$numberOfFiles.$extension';

    return newName;
  }
}
