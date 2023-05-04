import 'dart:convert';

import 'package:blip_ds/blip_ds.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../models/ds_country.model.dart';

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
  // final String initialCountry = 'BR';

  // final PhoneNumber number = PhoneNumber(isoCode: 'BR');

  // final TextEditingController controller = TextEditingController();
  List<DSCountry> _listCountries = [];
  final dropdownValue = Rx<DSCountry?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final jsonString = await rootBundle.loadString(
        'packages/${DSUtils.packageName}/assets/jsons/countries.json',
      );
      final jsonMap = jsonDecode(jsonString) as List;
      _listCountries = jsonMap.map((e) => DSCountry.fromJson(e)).toList();
      dropdownValue.value = _listCountries.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          DropdownButton<DSCountry>(
            //isExpanded: true,
            value: dropdownValue.value,
            icon: const Icon(
              DSIcons.arrow_down_outline,
              size: 16.0,
            ),
            elevation: 16, //verificar
            //style:
            underline: const SizedBox.shrink(),
            onChanged: (value) => dropdownValue.value = value!,
            selectedItemBuilder: (BuildContext context) {
              return _listCountries
                  .map<SvgPicture>(
                    (country) => SvgPicture.asset(
                      'assets/svg/flags/${country.flag}.svg',
                      width: 22.0,
                      height: 16.0,
                      package: DSUtils.packageName,
                    ),
                  )
                  .toList();
            },
            items: _listCountries
                .map<DropdownMenuItem<DSCountry>>(
                  (country) => DropdownMenuItem<DSCountry>(
                    value: country,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/flags/${country.flag}.svg',
                          package: DSUtils.packageName,
                          width: 22.0,
                          height: 16.0,
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(child: Text(country.code)),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.phone, //TODO ou usar o .number??
                showCursor: true,
                cursorColor: DSColors.primaryMain,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Número de telefone',
                  hintStyle: DSBodyTextStyle(color: DSColors.neutralMediumWave),
                ),
                inputFormatters: [maskFormatter],
              ),
            ),
          ),
        ],

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
      mask: '+# (##) #####-####', //TODO rever esses valores
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
