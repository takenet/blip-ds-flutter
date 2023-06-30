import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/themes/texts/styles/ds_text_style.theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../models/ds_country.model.dart';
import '../utils/ds_bottomsheet_countries.widget.dart';

class DSPhoneInput extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool shouldFocus;
  final bool shouldShowHint;
  final void Function(DSCountry)? onChangeCountry;

  const DSPhoneInput({
    super.key,
    this.hintText,
    required this.controller,
    this.onChangeCountry,
    this.errorText,
    this.onChanged,
    this.shouldFocus = false,
    this.shouldShowHint = false,
  });

  @override
  State<DSPhoneInput> createState() => _DSPhoneInputState();
}

class _DSPhoneInputState extends State<DSPhoneInput> {
  final _dropdownValue = Rx<DSCountry>(DSUtils.countriesList.first);
  final _focusNode = FocusNode();

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
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
        decoration: BoxDecoration(
          color: DSColors.neutralLightSnow,
          border: Border.all(color: _color()),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: widget.shouldShowHint && _focusNode.hasFocus,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 0),
                child: DSText(
                  widget.hintText,
                  style: const DSTextStyle(
                    fontSize: 8,
                    fontWeight: DSFontWeights.bold,
                    color: DSColors.neutralMediumCloud,
                  ),
                  height: 0,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: GestureDetector(
                          onTap: () async {
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                () => SvgPicture.asset(
                                  'assets/svg/flags/${_dropdownValue.value.flag}.svg',
                                  width: 22.0,
                                  package: DSUtils.packageName,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 4.0,
                                ),
                                child: Icon(
                                  DSIcons.arrow_down_outline,
                                  size: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => DSBodyText(
                          _dropdownValue.value.code,
                          color: DSColors.neutralMediumElephant,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: widget.controller,
                    focusNode: _focusNode,
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
              ],
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

  Color _color() {
    if (widget.errorText != null) {
      return DSColors.extendRedsDelete;
    } else if (_focusNode.hasFocus && widget.shouldFocus) {
      return DSColors.primaryNight;
    } else {
      return DSColors.neutralMediumWave;
    }
  }
}
