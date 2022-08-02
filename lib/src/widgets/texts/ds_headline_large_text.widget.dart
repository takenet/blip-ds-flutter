import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

/// A Design System's [Text] primarily used by large titles.
///
/// Sets [DSHeadlineLargeTextStyle] as [style] default value. This style's font variant is $fs-20-h2.
class DSHeadlineLargeText extends DSText {
  /// Creates a Design System's [Text] with $fs-20-h2 font variant.
  const DSHeadlineLargeText({
    required super.text,
    super.key,
  }) : super(
          style: const DSHeadlineLargeTextStyle(),
        );
}
