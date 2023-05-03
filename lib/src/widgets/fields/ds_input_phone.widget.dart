// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
//import 'dart:io';

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
  // String dropDownValue = countries.first;
  // final String initialCountry = 'BR';

  // final PhoneNumber number = PhoneNumber(isoCode: 'BR');

  // final TextEditingController controller = TextEditingController();
  late List<DSInputPhoneModel> _listInputPhoneModel = [];
  String? dropdownValue;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final jsonString = await rootBundle.loadString(
        'packages/${DSUtils.packageName}/assets/jsons/countries.json',
      );
      final List<dynamic> jsonMap = const JsonDecoder().convert(jsonString);
      _listInputPhoneModel =
          jsonMap.map((e) => DSInputPhoneModel.fromMap(e)).toList();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              Expanded(
                //TODO verificar o expanded
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    DSIcons.arrow_down_outline,
                    size: 16.0,
                  ),
                  elevation: 16, //verificar
                  //style:
                  underline: const SizedBox.shrink(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return _listInputPhoneModel
                        .map<SvgPicture>(
                            (DSInputPhoneModel value) => SvgPicture.asset(
                                  'assets/svg/flags/${value.flag}.svg',
                                  width: 22.0,
                                  height: 16.0,
                                  package: DSUtils.packageName,
                                ))
                        .toList();
                  },
                  items: _listInputPhoneModel.map<DropdownMenuItem<String>>(
                    (DSInputPhoneModel value) {
                      return DropdownMenuItem<String>(
                        value: value.code,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/flags/${value.flag}.svg',
                              package: DSUtils.packageName,
                              width: 22.0,
                              height: 16.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(value.code),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    autofocus: true,
                    keyboardType:
                        TextInputType.phone, //TODO ou usar o .number??
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
