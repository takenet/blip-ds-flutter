import 'dart:core';

import 'package:phone_number/phone_number.dart';

extension DSStringExtension on String {
  Future<String> asPhoneNumber() async {
    try {
      final plugin = PhoneNumberUtil();

      String phone = startsWith('+') ? this : '+$this';

      if (phone.startsWith('+55') && phone.length == 13) {
        phone = '${phone.substring(0, 5)}9${phone.substring(5)}';
      }

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
