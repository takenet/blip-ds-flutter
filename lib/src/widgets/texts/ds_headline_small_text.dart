import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSHeadlineSmallText extends Text {
  const DSHeadlineSmallText({
    required String text,
    Key? key,
  }) : super(
          text,
          key: key,
          style: const DSHeadlineSmallTextStyle(),
        );
}
