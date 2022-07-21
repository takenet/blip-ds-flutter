import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.dart';

class DSButtonText extends DSText {
  DSButtonText({
    required super.text,
    super.key,
    super.color = DSColors.neutralLightSnow,
  }) : super(
          style: DSButtonTextStyle(
            color: color,
          ),
        );
}
