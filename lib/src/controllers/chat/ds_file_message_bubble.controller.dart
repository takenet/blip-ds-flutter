import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path_utils;

import 'package:blip_ds/src/services/ds_file.service.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';

class DSFileMessageBubbleController extends GetxController {
  final isDownloading = RxBool(false);

  String getFileSize(final int size) {
    return filesize(size, 1);
  }

  Icon getFileIcon(final String filename) {
    final String extension = path_utils.extension(filename).isNotEmpty
        ? path_utils.extension(filename).substring(1)
        : '';

    final type = extension.length > 3 ? extension.substring(0, 3) : extension;

    late final IconData icon;
    late final Color color;

    switch (type) {
      case 'csv':
        icon = DSIcons.file_name_csv_outline;
        color = DSColors.primaryGreensForest;
        break;
      case 'doc':
        icon = DSIcons.file_name_doc_outline;
        color = DSColors.primaryNight;
        break;
      case 'pdf':
        icon = DSIcons.file_name_pdf_outline;
        color = DSColors.extendRedsLipstick;
        break;
      case 'ppt':
        icon = DSIcons.file_name_ppt_outline;
        color = DSColors.primaryOrangesDoritos;
        break;
      case 'txt':
        icon = DSIcons.file_name_txt_outline;
        color = DSColors.neutralDarkRooftop;
        break;
      case 'xls':
        icon = DSIcons.file_name_xls_outline;
        color = DSColors.primaryGreensForest;
        break;
      case 'zip':
        icon = DSIcons.file_name_zip_outline;
        color = DSColors.extendBrownsWood;
        break;
      default:
        icon = DSIcons.file_empty_file_outline;
        color = DSColors.neutralDarkRooftop;
    }

    return Icon(
      icon,
      size: 40,
      color: color,
    );
  }

  Future<void> openFile(
    final String filename,
    final String url,
  ) =>
      DSFileService.open(
        filename,
        url,
        onDownloadStateChange: (loading) => isDownloading.value = loading,
      );
}
