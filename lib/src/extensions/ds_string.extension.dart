import 'dart:core';

import 'package:phone_number/phone_number.dart';

extension DSStringExtension on String {
  Future<String> asPhoneNumber() async {
    try {
      final plugin = PhoneNumberUtil();

      final phone = startsWith('+') ? this : '+$this';
      final regionCode = (await plugin.parse(phone)).regionCode;

      return plugin.format(
        phone,
        regionCode,
      );
    } catch (_) {
      return this;
    }
  }
}
