import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';

/// A Design System's [Text] primarily used by buttons.
///
/// Sets [DSButtonTextStyle] as [style] default value.
class DSButtonText extends DSText {
  DSButtonText({
    required super.text,
    required super.color,
    super.key,
  }) : super(
          style: DSButtonTextStyle(
            color: color,
          ),
        );
}
