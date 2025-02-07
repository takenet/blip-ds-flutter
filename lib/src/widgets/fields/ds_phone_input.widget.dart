import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_country.model.dart';
import '../../services/ds_theme.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/colors/ds_dark_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../themes/texts/styles/ds_text_style.theme.dart';
import '../../themes/texts/utils/ds_font_families.theme.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../../utils/ds_utils.util.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_small_text.widget.dart';
import '../texts/ds_text.widget.dart';
import '../utils/ds_bottomsheet_countries.widget.dart';

class DSPhoneInput extends StatefulWidget {
  const DSPhoneInput({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.onChangeCountry,
    this.errorText,
    this.onChanged,
    this.shouldFocus = false,
    this.initialCountry,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool shouldFocus;
  final void Function(DSCountry)? onChangeCountry;
  final DSCountry? initialCountry;

  @override
  State<DSPhoneInput> createState() => _DSPhoneInputState();
}

class _DSPhoneInputState extends State<DSPhoneInput> {
  final _dropdownValue = Rx<DSCountry>(DSUtils.countriesList.first);
  final _borderColor = Rx(DSColors.neutralLightBox);
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
    _focusNode.addListener(() {
      _borderColor.value = _color();
    });

    _dropdownValue.value =
        widget.initialCountry ?? (DSUtils.countriesList.first);

    DSBottomSheetCountries.selectedCountry.value = widget.initialCountry;
    widget.onChangeCountry?.call(_dropdownValue.value);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _borderColor.value = _color();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Container(
              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 4.0, 0.0),
              decoration: BoxDecoration(
                color: DSThemeService.isDarkMode
                    ? DSDarkColors.surface3
                    : DSColors.neutralLightSnow,
                border: Border.all(color: _borderColor.value),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: widget.labelText?.isNotEmpty ?? false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: DSText(
                        widget.labelText,
                        style: DSTextStyle(
                          fontSize: 9.0,
                          fontWeight: DSFontWeights.bold,
                          color: DSThemeService.isDarkMode
                              ? DSColors.neutralLightSnow
                              : DSColors.neutralMediumCloud,
                        ),
                        height: 0.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                  final result =
                                      await DSBottomSheetCountries.show();

                                  if (result == null) {
                                    return;
                                  }

                                  _dropdownValue.value = result;

                                  updatePhoneMask(
                                    phoneNumber: widget.controller.text,
                                  );

                                  widget.onChangeCountry
                                      ?.call(_dropdownValue.value);
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 7.0,
                            bottom: 8.0,
                          ),
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
                            style: TextStyle(
                              fontSize: 16.0,
                              color: DSThemeService.foregoundColor,
                              fontFamily: DSFontFamilies.nunitoSans,
                            ),
                            keyboardType: TextInputType.number,
                            showCursor: true,
                            cursorColor: DSColors.primaryMain,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: widget.hintText ??
                                  widget.labelText ??
                                  'phone.number'.translate(),
                              hintStyle: const DSBodyTextStyle(
                                color: DSColors.neutralMediumWave,
                              ),
                            ),
                            inputFormatters: [maskFormatter],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  const Icon(DSIcons.error_solid,
                      color: DSColors.extendRedsDelete),
                  const SizedBox(width: 6.0),
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

  Color _color() {
    if (widget.errorText != null) {
      return DSColors.extendRedsDelete;
    } else if (_focusNode.hasFocus && widget.shouldFocus) {
      return DSColors.primaryNight;
    } else {
      return DSThemeService.isDarkMode
          ? DSDarkColors.surface0
          : DSColors.neutralMediumWave;
    }
  }
}
