import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../blip_ds.dart';
import '../../models/ds_country.model.dart';
import '../fields/ds_search_input.widget.dart';

abstract class DSBottomSheetCountries {
  static final showClearButton = RxBool(false);
  static final _filterCountries = RxList<DSCountry>();
  static final controller = TextEditingController();
  static final selectedCountry = Rxn<DSCountry?>();

  static show() {
    _filterCountries.assignAll(DSUtils.countriesList);
    selectedCountry.value ??= _filterCountries.first;
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
                    'País',
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
                color: DSColors.neutralLightSnow,
                hintText: 'Buscar por nome do país ou código',
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
    return Obx(
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
                          height: 16.0,
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
    );
  }
}
