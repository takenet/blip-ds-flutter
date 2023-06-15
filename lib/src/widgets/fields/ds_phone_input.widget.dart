import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../models/ds_country.model.dart';
import '../utils/ds_bottomsheet_countries.widget.dart';

class DSPhoneInput extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final void Function(DSCountry)? onChangeCountry;

  const DSPhoneInput({
    super.key,
    this.hintText,
    required this.controller,
    this.onChangeCountry,
    this.errorText,
    this.onChanged,
  });

  @override
  State<DSPhoneInput> createState() => _DSPhoneInputState();
}

class _DSPhoneInputState extends State<DSPhoneInput> {
  final _dropdownValue = Rx<DSCountry>(DSUtils.countriesList.first);

  // TODO: get masks considering selected country.
  static const _defaultMask = '#################';
  static const _tenDigitsMask = '(##) ####-#####';
  static const _elevenDigitsMask = '(##) #####-####';
  static const _brazilCode = '+55';

  late final maskFormatter = MaskTextInputFormatter(
    mask: _tenDigitsMask,
    filter: {"#": RegExp(r'[0-9]')},
  );

  // TODO: check if can use DSTextField or DSInputContainer
  @override
  void initState() {
    super.initState();
    DSBottomSheetCountries.selectedCountry.value = null;
    widget.onChangeCountry?.call(_dropdownValue.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: DSColors.neutralMediumWave,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                color: DSColors.neutralLightSnow),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: DSTertiaryButton(
                    leadingIcon: Obx(
                      () => SvgPicture.asset(
                        'assets/svg/flags/${_dropdownValue.value.flag}.svg',
                        width: 22.0,
                        package: DSUtils.packageName,
                      ),
                    ),
                    trailingIcon: const Padding(
                      padding: EdgeInsets.only(
                        left: 4.0,
                      ),
                      child: Icon(
                        DSIcons.arrow_down_outline,
                        size: 16.0,
                      ),
                    ),
                    onPressed: () async {
                      final result = await DSBottomSheetCountries.show();

                      if (result == null) {
                        return;
                      }

                      _dropdownValue.value = result;

                      updatePhoneMask(
                        phoneNumber: widget.controller.text,
                      );

                      widget.onChangeCountry?.call(_dropdownValue.value);
                    },
                  ),
                ),
                Obx(
                  () => DSBodyText(
                    _dropdownValue.value.code,
                    color: DSColors.neutralMediumElephant,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: TextFormField(
                      controller: widget.controller,
                      onChanged: (value) {
                        updatePhoneMask(
                          phoneNumber: value,
                        );
                        if (widget.onChanged != null) {
                          widget.onChanged!(value);
                        }
                      },
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
                        hintText: widget.hintText ?? 'Número de telefone',
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
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  const Icon(DSIcons.error_solid,
                      color: DSColors.extendRedsDelete),
                  const SizedBox(width: 6),
                  DSCaptionSmallText(
                    widget.errorText,
                    color: DSColors.extendRedsDelete,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void updatePhoneMask({
    required String phoneNumber,
  }) =>
      widget.controller.value = maskFormatter.updateMask(
        mask: _dropdownValue.value.code != _brazilCode
            ? _defaultMask
            : phoneNumber.replaceAll(RegExp('[^0-9]'), '').length <= 10
                ? _tenDigitsMask
                : _elevenDigitsMask,
      );
}
