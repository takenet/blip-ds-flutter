// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
        searchBoxDecoration: const InputDecoration(
            //icon: DSIcons.arrow_drop_down_circle,

            ),
        inputDecoration: const InputDecoration(
          border: InputBorder.none,
        ),
        cursorColor: DSColors.primaryMain,
        selectorTextStyle: const TextStyle(
          color: DSColors.neutralMediumElephant,
        ),
        textStyle:
            const TextStyle(fontSize: 16.0, color: DSColors.neutralDarkCity),
        spaceBetweenSelectorAndTextField: 8.0,
        hintText: "teste",
        initialValue: number, 
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true,),
        textFieldController: controller,
        maxLength: 15,
        onInputChanged: (PhoneNumber number) {
          number.phoneNumber;
        },
      ),
    );
  }
}
