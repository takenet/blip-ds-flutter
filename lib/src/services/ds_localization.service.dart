import 'package:flutter/material.dart';

abstract class DSLocalizationService {
  static Locale? _locale;
  static final Map<String, dynamic> _translations = {};

  static setLocale(final Locale locale) => _locale = locale;
  static setTranslations(final Map<String, dynamic> translations) =>
      _translations.addAll(translations);

  static Locale? get locale => _locale;
  static Map<String, dynamic>? get translations => _translations;
}
