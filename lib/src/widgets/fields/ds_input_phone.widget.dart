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
    return Container(
      child: Row(
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
              final mask = result.name == 'Brasil'
                  ? '(##) ####-#####'
                  : '#################';
              maskFormatter.updateMask(mask: mask);
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
              child: TextFormField(
                onChanged: (value) {
                  final phoneNumber = value.replaceAll(RegExp('[^0-9]'), '');
                  final mask = phoneNumber.length >= 10
                      ? '(##) #####-####'
                      : '(##) ####-#####';
                  maskFormatter.updateMask(mask: mask);
                },
                style: const TextStyle(
                    fontSize: 16.0,
                    color: DSColors.neutralDarkCity,
                    fontFamily: DSFontFamilies.nunitoSans),
                autofocus: true,
                keyboardType: TextInputType.phone,
                showCursor: true,
                cursorColor: DSColors.primaryMain,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText ?? 'Número de telefone',
                  hintStyle:
                      const DSBodyTextStyle(color: DSColors.neutralMediumWave),
                ),
                inputFormatters: [maskFormatter],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final maskFormatter = MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
