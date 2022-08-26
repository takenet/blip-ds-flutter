import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

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
