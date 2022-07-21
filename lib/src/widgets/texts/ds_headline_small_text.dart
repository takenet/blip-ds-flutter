import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.dart';

class DSHeadlineSmallText extends DSText {
  const DSHeadlineSmallText({
    required super.text,
    super.key,
  }) : super(
          style: const DSHeadlineSmallTextStyle(),
        );
}
