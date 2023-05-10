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
  // dynamic textEditingController = TextEditingController();

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
                // controller: textEditingController =
                //     maskFormatter.updateMask(mask: '(##) #####-####'),
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
    );
  }

  dynamic maskFormatterBrazil = MaskTextInputFormatter(
      mask: '(##) ####-####', //TODO rever esses valores
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  dynamic maskFormatter = MaskTextInputFormatter(
      mask: '#######-####', //TODO rever esses valores
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
