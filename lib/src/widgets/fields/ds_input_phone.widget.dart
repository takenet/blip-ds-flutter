// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/models/ds_input_phone.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

//import '../../models/ds_input_phone.model.dart';

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
  // List<DSInputPhoneModel> countries = getDSInputPhoneModel(){

  // };
  // String dropDownValue = countries.first;
  // final String initialCountry = 'BR';

  // final PhoneNumber number = PhoneNumber(isoCode: 'BR');

  // final TextEditingController controller = TextEditingController();
  late List<DSInputPhoneModel> _inputPhoneModel = [];
//final String dropDownFirst = _inputPhoneModel.first;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final jsonString = await DefaultAssetBundle.of(context)
          .loadString('jsons/countries.json');
      final Map<String, dynamic> jsonMap =
          const JsonDecoder().convert(jsonString);
      _inputPhoneModel = (jsonMap['data'] as List)
          .map((e) => DSInputPhoneModel.fromMap(e))
          .toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
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
                underline: const SizedBox.shrink(),
                icon: const Icon(DSIcons.arrow_ball_down_outline),
                items: _inputPhoneModel.map<DropdownMenuItem<String>>(
                  (DSInputPhoneModel value) {
                    return DropdownMenuItem<String>(
                      value: value.code,
                      child: Row(
                        children: const [
                          SizedBox(width: 10.0),
                        ],
                      ),
                    );
                  },
                ).toList(),
                onChanged: (String? value) {
                  setState(() {
                    //dropDownFirst = value!;
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return _inputPhoneModel
                      .map<SvgPicture>((DSInputPhoneModel value) =>
                          SvgPicture.asset(
                              'assets/svg/flags/${value.flag}.svg'))
                      .toList();
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.phone, //ou usar o .number??
                    showCursor: true,
                    cursorColor: DSColors.primaryMain,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Número de telefone',
                      hintStyle:
                          DSBodyTextStyle(color: DSColors.neutralMediumWave),
                    ),
                    inputFormatters: [maskFormatter],
                  ),
                ),
              ),
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
          ),
    );
  }

  dynamic maskFormatter = MaskTextInputFormatter(
      mask: '+# (##) #####-####', //rever esses valores
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
