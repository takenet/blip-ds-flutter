// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DSInputPhone extends StatefulWidget {
  final String? hintText;

  const DSInputPhone({
    super.key,
    this.hintText,
  });

  @override
  State<DSInputPhone> createState() => _DSInputPhoneState();
}

class _DSInputPhoneState extends State<DSInputPhone> {
  List<DropdownMenu> list = ;
  String dropDownValue = list.first;
  // final String initialCountry = 'BR';

  // final PhoneNumber number = PhoneNumber(isoCode: 'BR');

  // final TextEditingController controller = TextEditingController();

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
        child: Row(
          children: [
            DropdownButton<String>(
                icon: SvgPicture.asset(
                  'assets/svg/brazil_flag.svg',
                ),
                items: items,
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                  });
                }),
                const TextField(keyboardType: TextInputType.phone,showCursor: true,cursorColor: DSColors.primaryMain,),
          ],
        )

        // InternationalPhoneNumberInput(
        //   inputDecoration: const InputDecoration(
        //     hintText: "Número de telefone",
        //     hintStyle: DSBodyTextStyle(color: DSColors.neutralMediumWave),
        //     border: InputBorder.none,
        //   ),
        //   cursorColor: DSColors.primaryMain,
        //   selectorTextStyle: const TextStyle(
        //     color: DSColors.neutralMediumElephant,
        //   ),
        //   spaceBetweenSelectorAndTextField: 8.0,
        //   initialValue: number,
        //   //keyboardType: TextInputType.phone,
        //   //   signed: true,
        //   //   decimal: true,

        //   textFieldController: controller,
        //   maxLength: 15,
        //   onInputChanged: (PhoneNumber number) {
        //     number.phoneNumber;
        //   },
        // ),
        );
  }
}
