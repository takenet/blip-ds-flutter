import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.dart';

class DSHeadlineLargeText extends DSText {
  const DSHeadlineLargeText({
    required super.text,
    super.key,
  }) : super(
          style: const DSHeadlineLargeTextStyle(),
        );
}
