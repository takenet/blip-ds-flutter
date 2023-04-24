// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:blip_ds/src/widgets/fields/ds_input_decoration.widget.dart';

class DSInputPhone extends StatelessWidget {
  final String? hintText;
  final String initialCountry = 'BR';
  final PhoneNumber number = PhoneNumber(isoCode: 'BR');
  final TextEditingController controller = TextEditingController();
  DSInputPhone({
    Key? key,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSInputDecoration(
        child: InternationalPhoneNumberInput(
      searchBoxDecoration: const InputDecoration(hoverColor: Colors.red), inputBorder: InputBorder.,
      hintText: hintText,
      initialValue: number,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      textFieldController: controller,
      maxLength: 15,
      onInputChanged: (PhoneNumber number) {
        number.phoneNumber;
      },
    ));
  }
}
