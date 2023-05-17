import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../models/ds_country.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../themes/texts/utils/ds_font_families.theme.dart';
import '../../utils/ds_utils.util.dart';
import '../buttons/ds_tertiary_button.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../utils/ds_bottomsheet_countries.widget.dart';

class DSInputPhone extends StatelessWidget {
  final String? hintText;

  DSInputPhone({
    super.key,
    this.hintText,
  });

  final dropdownValue = Rx<DSCountry>(DSUtils.countriesList.first);
  final inputController = TextEditingController();

  // TODO: get masks considering selected country.
  final defaultMask = '#################';
  final tenDigitsMask = '(##) ####-#####';
  final elevenDigitsMask = '(##) #####-####';

  late final maskFormatter = MaskTextInputFormatter(
    mask: tenDigitsMask,
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: DSColors.neutralMediumWave,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: DSColors.neutralLightSnow),
        child: Row(
          children: [
            DSTertiaryButton(
              leadingIcon: Obx(
                () => SvgPicture.asset(
                  'assets/svg/flags/${dropdownValue.value.flag}.svg',
                  width: 22.0,
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
                dropdownValue.value = await DSBottomSheetCountries.show();

                updatePhoneMask(
                  phoneNumber: inputController.text,
                );
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
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: TextFormField(
                  controller: inputController,
                  onChanged: (value) => updatePhoneMask(
                    phoneNumber: value,
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: DSColors.neutralDarkCity,
                    fontFamily: DSFontFamilies.nunitoSans,
                  ),
                  keyboardType: TextInputType.number,
                  showCursor: true,
                  cursorColor: DSColors.primaryMain,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText ?? 'Número de telefone',
                    hintStyle: const DSBodyTextStyle(
                        color: DSColors.neutralMediumWave),
                  ),
                  inputFormatters: [maskFormatter],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatePhoneMask({
    required String phoneNumber,
  }) {
    inputController.value = maskFormatter.updateMask(
      mask: dropdownValue.value.name != 'Brasil'
          ? defaultMask
          : phoneNumber.replaceAll(RegExp('[^0-9]'), '').length <= 10
              ? tenDigitsMask
              : elevenDigitsMask,
    );
  }
}
