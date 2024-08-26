import '../services/ds_localization.service.dart';

extension DSLocalizationExtension on String {
  translate() {
    final locale = DSLocalizationService.locale ?? 'pt_BR';
    final translations =
        DSLocalizationService.translations?[locale.toString()] ?? {};
    return translations[this] ?? this;
  }
}
