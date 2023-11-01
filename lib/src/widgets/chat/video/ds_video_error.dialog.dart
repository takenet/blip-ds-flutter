import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

import '../../../services/ds_dialog.service.dart';
import '../../../services/ds_file.service.dart';
import '../../../utils/ds_directory_formatter.util.dart';
import '../../buttons/ds_primary_button.widget.dart';
import '../../buttons/ds_secondary_button.widget.dart';

abstract class DSVideoErrorDialog {
  static Future<void> show({
    required final String url,
    final Map<String, String?>? httpHeaders,
  }) async {
    // TODO: translate
    await DSDialogService(
      title: 'Erro ao reproduzir o vídeo',
      text:
          'Encontramos um erro ao reproduzir o vídeo. Você deseja tentar abrir o vídeo externamente?',
      primaryButton: DSPrimaryButton(
        onPressed: () async {
          Get.back();

          final cachePath = await DSDirectoryFormatter.getCachePath(
            type: 'video/mp4',
            filename: md5.convert(utf8.encode(Uri.parse(url).path)).toString(),
          );

          await DSFileService.open(
            url: url,
            path: cachePath,
            httpHeaders: httpHeaders,
          );
        },
        label: 'Sim',
      ),
      secondaryButton: DSSecondaryButton(
        onPressed: () => Get.back(),
        label: 'Não',
      ),
      context: Get.context!,
    ).showError();
  }
}
