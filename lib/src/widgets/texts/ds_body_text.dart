import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.dart';

class DSBodyText extends DSText {
  DSBodyText({
    required super.text,
    super.key,
    super.fontWeight,
    super.color,
    super.overflow,
    super.decoration,
  }) : super(
          style: DSBodyTextStyle(
            fontWeight: fontWeight,
            color: color,
            overflow: overflow,
            decoration: decoration,
          ),
        );
}
