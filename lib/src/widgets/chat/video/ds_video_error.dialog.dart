import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

import '../../../extensions/ds_localization.extension.dart';
import '../../../services/ds_context.service.dart';
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
    await DSDialogService(
      title: 'video-error.reproduction-title'.translate(),
      text: 'video-error.reproduction-message'.translate(),
      primaryButton: DSPrimaryButton(
          onPressed: () async {
            Get.back();

            final cachePath = await DSDirectoryFormatter.getCachePath(
              type: 'video/mp4',
              filename:
                  md5.convert(utf8.encode(Uri.parse(url).path)).toString(),
            );

            await DSFileService.open(
              url: url,
              path: cachePath,
              httpHeaders: httpHeaders,
            );
          },
          label: 'message.yes'.translate()),
      secondaryButton: DSSecondaryButton(
        onPressed: () => Get.back(),
        label: 'message.no'.translate(),
      ),
      context: DSContextService.context!,
    ).showError();
  }
}
