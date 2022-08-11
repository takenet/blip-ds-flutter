import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

/// A Design System's [Text] primarily used by small titles.
///
/// Sets [DSHeadlineSmallTextStyle] as [style] default value. This style's font variant is $fs-16-p1.
class DSHeadlineSmallText extends DSText {
  /// Creates a Design System's [Text] with $fs-16-p1 font variant.
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
