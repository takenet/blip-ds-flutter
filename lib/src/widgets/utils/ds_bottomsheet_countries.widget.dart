import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_country.model.dart';
import '../../services/ds_bottom_sheet.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../utils/ds_utils.util.dart';
import '../buttons/ds_icon_button.widget.dart';
import '../fields/ds_search_input.widget.dart';
import '../radio/ds_radio_tile.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_headline_large_text.widget.dart';
import 'ds_divider.widget.dart';

abstract class DSBottomSheetCountries {
  static final showClearButton = RxBool(false);
  static final _filterCountries = RxList<DSCountry>();
  static final controller = TextEditingController();
  static final selectedCountry = Rxn<DSCountry?>();

  static show() {
    _filterCountries.assignAll(DSUtils.countriesList);
    selectedCountry.value ??= _filterCountries.first;
    _onClear();
    return _bottomSheetCountries();
  }

  static Future<void> _bottomSheetCountries() {
    return DSBottomSheetService(
      fixedHeader: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SafeArea(
              top: false,
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DSHeadlineLargeText(
                    'country.country-name'.translate(),
                  ),
                  DSIconButton(
                    onPressed: () {
                      Get.back(
                        result: selectedCountry.value,
                      );
                    },
                    icon: const Icon(DSIcons.close_outline,
                        color: DSColors.neutralDarkRooftop),
                  ),
                ],
              ),
            ),
          ),
          const DSDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Obx(
              () => DSSearchInput(
                iconBackgroundColor: Colors.transparent,
                hintText: 'country.search'.translate(),
                onSearch: _onSearch,
                onClear: _onClear,
                showSuffixIcon: showClearButton.value,
                controller: controller,
              ),
            ),
          ),
          const DSDivider(),
        ],
      ),
      context: Get.context!,
      builder: (_) => _builderCountries(),
    ).show();
  }

  static Future<void> _onSearch(String searchString) async {
    showClearButton.value = searchString.isNotEmpty;
    _filterCountries.assignAll(
      DSUtils.countriesList.where((country) =>
          country.name.toLowerCase().contains(searchString.toLowerCase()) ||
          country.code.toLowerCase().contains(searchString.toLowerCase())),
    );
  }

  static Future<void> _onClear() async {
    _filterCountries.assignAll(DSUtils.countriesList);
    controller.clear();
    showClearButton.value = false;
  }

  static Widget _builderCountries() {
    return SafeArea(
      child: Obx(
        () => ListView.builder(
          itemBuilder: (_, index) {
            final country = _filterCountries[index];
            return Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    DSRadioTile<DSCountry>(
                      value: country,
                      onChanged: (value) {
                        selectedCountry.value = value!;
                        Get.back(result: selectedCountry.value);
                      },
                      title: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/flags/${country.flag}.svg',
                            width: 22.0,
                            package: DSUtils.packageName,
                          ),
                          DSBodyText(' ${country.name} '),
                          DSBodyText(country.code),
                        ],
                      ),
                      groupValue: selectedCountry.value,
                    ),
                    const DSDivider(),
                  ],
                ),
              ),
            );
          },
          itemCount: _filterCountries.length,
        ),
      ),
    );
  }
}
