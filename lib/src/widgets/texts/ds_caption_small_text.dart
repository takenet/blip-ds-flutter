import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.dart';

class DSCaptionSmallText extends DSText {
  DSCaptionSmallText({
    required super.text,
    super.key,
    super.fontWeight,
    super.color,
  }) : super(
          style: DSCaptionSmallTextStyle(
            fontWeight: fontWeight,
            color: color,
          ),
        );
}
