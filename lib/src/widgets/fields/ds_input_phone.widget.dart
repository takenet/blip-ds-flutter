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

  final dropdownValue =
      Rx<DSCountry>(DSBottomSheetCountries.listCountries.first);

  final String mask1 = '(##) #####-####';

  final String mask2 = '#################';

  final String mask3 = '(##) #####-####';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: DSColors.neutralMediumWave),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: DSColors.neutralLightSnow),
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
                final mask = result.name == 'Brasil' ? mask1 : mask2;
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
                    final mask = dropdownValue.value.name != 'Brasil'
                        ? mask2
                        : phoneNumber.length >= 10
                            ? mask1
                            : mask3;
                    maskFormatter.updateMask(mask: mask);
                  },
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: DSColors.neutralDarkCity,
                      fontFamily: DSFontFamilies.nunitoSans),
                  keyboardType: TextInputType.phone,
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

  final maskFormatter = MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
