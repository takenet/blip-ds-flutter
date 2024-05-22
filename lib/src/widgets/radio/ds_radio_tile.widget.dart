import 'package:flutter/material.dart';

import 'ds_radio.widget.dart';

class DSRadioTile<T> extends StatelessWidget {
  /// Create a Design System's tile widget with a radio button
  ///
  ///The radio buttons will need to be grouped using the [groupValue] parameter,
  ///which will determine which value to capture in the group on each button determined by [value].
  ///
  ///A title can be determined using [title], which will also be clickable and thus
  ///selecting the radio button.
  ///
  ///To disable the radio button, use the [isEnabled] property
  const DSRadioTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.groupValue,
    this.subTitle,
    this.isEnabled = true,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 16.0),
  });

  /// Clickable radio group title allowing you to select an option.
  final Widget title;

  /// Determines the grouping of buttons allowing one of them to be selected
  ///
  /// The <T> type determines which type of variable to use as [value],
  /// which can be int, String, or even an object.
  final T? groupValue;

  /// Radio tile subtitle widget.
  final Widget? subTitle;

  /// Allows you to enable or disable the use of the button group, setting a
  /// default value and preventing other options from being returned.
  final bool isEnabled;

  /// Event that fires when an option within the group is changed.
  final ValueChanged<T?>? onChanged;

  /// Button value that will be returned when it is selected.
  final T value;

  /// Content spacing inner border size
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? () => onChanged!(value) : null,
      child: Padding(
        padding: contentPadding,
        child: Row(
          children: [
            DSRadio(
              isEnabled: isEnabled,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  if (subTitle != null) ...[
                    const SizedBox(
                      height: 5.0,
                    ),
                    subTitle!
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
