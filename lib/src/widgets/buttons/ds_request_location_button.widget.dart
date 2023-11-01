import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_button.widget.dart';

class DSRequestLocationButton extends DSButton {
  final void Function(String, Map<String, dynamic>)? onSelected;
  DSRequestLocationButton({
    super.key,
    required super.label,
    this.onSelected,
  }) : super(
          onPressed: null,
          // onPressed: () {
          //   if (onSelected != null) {
          //     onSelected(
          //       '',
          //       {
          //         type: 'application/vnd.lime.location+json',
          //         content: {latitude, longitude}
          //       },
          //     );
          //   }
          // }, //TODO: get geolocation
          borderRadius: 20.0,
          leadingIcon: const Icon(
            DSIcons.localization_outline,
            color: DSColors.neutralDarkCity,
          ),
          backgroundColor: DSColors.primaryLight,
          foregroundColor: DSColors.neutralDarkCity,
        );
}
