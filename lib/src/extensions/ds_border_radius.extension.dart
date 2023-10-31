import 'package:flutter/material.dart';

import '../enums/ds_border_radius.enum.dart';

/// A Design System's extension that adds functionalities to [DSBorderRadius] enum.
extension DSBorderRadiusExtension on DSBorderRadius {
  BorderRadius getCircularBorderRadius({
    required double maxRadius,
    double minRadius = 0.0,
  }) {
    return [this].getCircularBorderRadius(
      maxRadius: maxRadius,
      minRadius: minRadius,
    );
  }
}

/// A Design System's extension that adds functionalities to a list of [DSBorderRadius] enums.
extension DSBorderRadiusListExtension on List<DSBorderRadius> {
  BorderRadius getCircularBorderRadius({
    required double maxRadius,
    double minRadius = 0.0,
  }) {
    final circularMaxRadius = Radius.circular(maxRadius);
    final circularMinRadius = Radius.circular(minRadius);

    return contains(DSBorderRadius.all) || isEmpty
        ? BorderRadius.all(circularMaxRadius)
        : BorderRadius.only(
            topLeft: contains(DSBorderRadius.topLeft)
                ? circularMaxRadius
                : circularMinRadius,
            topRight: contains(DSBorderRadius.topRight)
                ? circularMaxRadius
                : circularMinRadius,
            bottomLeft: contains(DSBorderRadius.bottomLeft)
                ? circularMaxRadius
                : circularMinRadius,
            bottomRight: contains(DSBorderRadius.bottomRight)
                ? circularMaxRadius
                : circularMinRadius,
          );
  }
}
