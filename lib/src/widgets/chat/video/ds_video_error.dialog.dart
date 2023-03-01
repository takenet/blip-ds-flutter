import 'package:get/get.dart';

import '../../../services/ds_dialog.service.dart';
import '../../../services/ds_file.service.dart';
import '../../buttons/ds_primary_button.widget.dart';
import '../../buttons/ds_secondary_button.widget.dart';

abstract class DSVideoErrorDialog {
  static Future<void> show(final String fileName, final String url) async {
    await DSDialogService(
      title: 'Erro ao reproduzir o vídeo',
      text:
          'Encontramos um erro ao reproduzir o vídeo. Você deseja tentar abrir o vídeo externamente?',
      primaryButton: DSPrimaryButton(
        onPressed: () async {
          Get.back();
          await DSFileService.open(fileName, url);
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