import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

/// A Design System's [Text] primarily used by body texts, like messages and inputs.
///
/// Sets [DSBodyTextStyle] as [style] default value.
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
