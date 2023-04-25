// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

//import 'package:blip_ds/src/widgets/fields/ds_input_decoration.widget.dart';

class DSInputPhone extends StatelessWidget {
  final String? hintText;
  final String initialCountry = 'BR';
  final PhoneNumber number = PhoneNumber(isoCode: 'BR');
  final TextEditingController controller = TextEditingController();
  DSInputPhone({
    super.key,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: DSColors.neutralMediumWave),
          top: BorderSide(color: DSColors.neutralMediumWave),
          left: BorderSide(color: DSColors.neutralMediumWave),
          right: BorderSide(color: DSColors.neutralMediumWave),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: InternationalPhoneNumberInput(
        inputDecoration: const InputDecoration(
          hintText: "Número de telefone",
          hintStyle: DSBodyTextStyle(color: DSColors.neutralMediumWave),
          border: InputBorder.none,
        ),
        cursorColor: DSColors.primaryMain,
        selectorTextStyle: const TextStyle(
          color: DSColors.neutralMediumElephant,
        ),
        spaceBetweenSelectorAndTextField: 8.0,
        initialValue: number,
        //keyboardType: TextInputType.phone,
        //   signed: true,
        //   decimal: true,

        textFieldController: controller,
        maxLength: 15,
        onInputChanged: (PhoneNumber number) {
          number.phoneNumber;
        },
      ),
    );
  }

  final maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
