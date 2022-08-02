import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

/// A Design System's [Text] primarily used by small titles.
///
/// Sets [DSHeadlineSmallTextStyle] as [style] default value.
class DSHeadlineSmallText extends DSText {
  DSHeadlineSmallText({
    required super.text,
    super.key,
    super.color,
  }) : super(
          style: DSHeadlineSmallTextStyle(
            color: color,
          ),
        );
}
