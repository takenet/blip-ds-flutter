import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

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
          // }, //TODO: pegar geolocation
          borderRadius: 20.0,
          leadingIcon: const Icon(
            DSIcons.localization_outline,
            color: DSColors.neutralDarkCity,
          ),
          backgroundColor: DSColors.primaryLight,
          foregroundColor: DSColors.neutralDarkCity,
        );
}
