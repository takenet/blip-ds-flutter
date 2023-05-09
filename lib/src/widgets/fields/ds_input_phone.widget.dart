import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../models/ds_country.model.dart';
import '../ds_bottomsheet_countries.widget.dart';

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
  final dropdownValue =
      Rx<DSCountry>(DSBottomSheetCountries.listCountries.first);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DSTertiaryButton(
          leadingIcon: Obx(
            () => SvgPicture.asset(
              'assets/svg/flags/${dropdownValue.value.flag}.svg',
              width: 22.0,
              height: 16.0,
              package: DSUtils.packageName,
            ),
          ),
          trailingIcon: const Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Icon(
              DSIcons.arrow_down_outline,
              size: 16.0,
            ),
          ),
          onPressed: () async {
            final result = await DSBottomSheetCountries.show();
            dropdownValue.value = result;
          },
        ),
        Obx(
          () => DSBodyText(
            dropdownValue.value.code,
            color: DSColors.neutralMediumElephant,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Obx(
              () => TextFormField(
                style: const TextStyle(
                    fontSize: 16.0,
                    color: DSColors.neutralDarkCity,
                    fontFamily: DSFontFamilies.nunitoSans),
                autofocus: true,
                keyboardType: TextInputType.phone, //TODO ou usar o .number??
                showCursor: true,
                cursorColor: DSColors.primaryMain,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      'Número de telefone', //TODO colocar variavel hint aqui
                  hintStyle: DSBodyTextStyle(color: DSColors.neutralMediumWave),
                ),

                inputFormatters: [
                  dropdownValue.value.flag == 'brazil_flag'
                      ? maskFormatterBrazil
                      : maskFormatter
                ],
              ),
            ),
          ),
        ),
      ],
      // DropdownButton<DSCountry>(
      //   //isExpanded: true,
      //   value: dropdownValue.value,
      //   icon: const Icon(
      //     DSIcons.arrow_down_outline,
      //     size: 16.0,
      //   ),
      //   elevation: 16, //verificar
      //   //style:
      //   underline: const SizedBox.shrink(),
      //   onChanged: (value) => dropdownValue.value = value!,
      //   selectedItemBuilder: (BuildContext context) {
      //     return _listCountries
      //         .map<SvgPicture>(
      //           (country) => SvgPicture.asset(
      //             'assets/svg/flags/${country.flag}.svg',
      //             width: 22.0,
      //             height: 16.0,
      //             package: DSUtils.packageName,
      //           ),
      //         )
      //         .toList();
      //   },
      //   items: _listCountries
      //       .map<DropdownMenuItem<DSCountry>>(
      //         (country) => DropdownMenuItem<DSCountry>(
      //           value: country,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               SvgPicture.asset(
      //                 'assets/svg/flags/${country.flag}.svg',
      //                 package: DSUtils.packageName,
      //                 width: 22.0,
      //                 height: 16.0,
      //               ),
      //               const SizedBox(width: 5.0),
      //               Flexible(
      //                 child: Text(country.code),
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //       .toList(),
      // ),

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

  // _bottomSheetCountries() {
  //   //TODO colocar outro arquivo
  //   return DSBottomSheetService(
  //     fixedHeader: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(left: 16.0),
  //           child: SafeArea(
  //             top: false,
  // bottom: false,
  // child: Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //     DSHeadlineLargeText(
  //       'País',
  //     ),
  //     DSIconButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       icon: const Icon(DSIcons.close_outline,
  //           color: DSColors.neutralDarkRooftop),
  //         ),
  //       ],
  //     ),
  //   ),
  // ),
  // const DSDivider(),
  // Padding(
  //   padding: const EdgeInsets.fromLTRB(
  //     16.0,
  //     8.0,
  //   16.0,
  //   8.0,
  // ),
  // child: Obx(
  //   () => DSAppSearchInput(
  //     onSearch: _onSearch,
  //     onClear: _onClear,
  //     showSuffixIcon: showClearButton.value,
  //     controller: controller,
  //             ),
  //           ),
  //         ),
  //         const DSDivider(),
  //       ],
  //     ),
  //     context: Get.context!,
  //     builder: (_) => _builderCountries(),
  //   ).show();
  // }

  // _onSearch(String searchString) {
  //   showClearButton.value = searchString.isNotEmpty;
  //   _filterCountries.assignAll(
  //     _listCountries.where((country) =>
  //         country.name.toLowerCase().contains(searchString.toLowerCase()) ||
  //         country.code.toLowerCase().contains(searchString.toLowerCase())),
  //   );
  // }

  // _onClear() {
  //   _filterCountries.assignAll(_listCountries);
  //   controller.clear();
  //   showClearButton.value = false;
  // }

  // Widget _builderCountries() { //FOI P/ o OUTRO ARQUIVO
  //   return Obx(
  //     () => ListView.builder(
  //       itemBuilder: (_, index) {
  //         final country = _filterCountries[index];
  //         return Obx(
  //           () => DSRadioTile<DSCountry>(
  //             value: country,
  //             onChanged: (value) {
  //               selectedCountry.value = value!;
  //               Get.back(result: selectedCountry.value);
  //             },
  //             title: Text(_listCountries[index].code),
  //             groupValue: selectedCountry.value,
  //           ),
  //         );
  //       },
  //       itemCount: _filterCountries.length,
  //     ),
  //   );
  // }

  //   List <DSCountry> countries =
  //       .map<DropdownMenuItem<DSCountry>>(
  //         (country) => DropdownMenuItem<DSCountry>(
  //           value: country,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               SvgPicture.asset(
  //                 'assets/svg/flags/${country.flag}.svg',
  //                 package: DSUtils.packageName,
  //                 width: 22.0,
  //                 height: 16.0,
  //               ),
  //               const SizedBox(width: 5.0),
  //               Flexible(
  //                 child: Text(country.code),
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //       .toList(),
  // ), dscheck box title ver page preferencias

  dynamic maskFormatterBrazil = MaskTextInputFormatter(
      mask: '(##) ####-#####', //TODO rever esses valores
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  dynamic maskFormatter = MaskTextInputFormatter(
      mask: '#######-####', //TODO rever esses valores
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
