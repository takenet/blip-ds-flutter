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
    String dir = path.dirname(filePath);
    final String formattedDir = _formatDir(type: type, dir: dir);
    final dirExists = await Directory(formattedDir).exists();
    if (!dirExists) {
      await Directory(formattedDir).create(recursive: true);
    }
    String newName = path.join(formattedDir, fileName);
    await File(filePath).rename(newName);
    return newName;
  }

  static Future<String> getPath({required DSFileType type}) async {
    final temporaryPath = (await getTemporaryDirectory()).path;
    final mediaPath = _formatDir(type: type, dir: temporaryPath);
    return mediaPath;
  }

  static String _formatDir({required DSFileType type, required String dir}) {
    return dir.replaceAll(
      dir.split('/').last,
      'BlipDesk/Media/${type.name.capitalizeFirst}',
    );
  }
}
