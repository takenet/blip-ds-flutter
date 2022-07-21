import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSHeadlineLargeText extends Text {
  const DSHeadlineLargeText({
    required String text,
    Key? key,
  }) : super(
          text,
          key: key,
          style: const DSHeadlineLargeTextStyle(),
        );
}
