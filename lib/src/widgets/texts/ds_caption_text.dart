import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.dart';

class DSCaptionText extends DSText {
  DSCaptionText({
    required super.text,
    super.key,
    super.fontWeight,
    super.color,
  }) : super(
          style: DSCaptionTextStyle(
            fontWeight: fontWeight,
            color: color,
          ),
        );
}
