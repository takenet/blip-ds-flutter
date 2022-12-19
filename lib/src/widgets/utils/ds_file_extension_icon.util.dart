import 'package:flutter/material.dart';

import '../../../blip_ds.dart';

class DSFileExtensionIcon extends StatelessWidget {
  final String filename;
  final double size;

  const DSFileExtensionIcon({
    super.key,
    required this.filename,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final extension = filename.substring(filename.lastIndexOf('.') + 1);

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
      color: color,
      size: size,
    );
  }
}
