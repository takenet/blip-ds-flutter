import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSRadioTile<T> extends StatelessWidget {
  /// Create a tile widget with a radio button for grouped use
  ///
  ///The radio buttons will need to be grouped using the [groupValue] parameter,
  ///which will determine which value to capture in the group on each button determined by [value].
  ///
  ///A title can be determined using [title], which will also be clickable and thus
  ///selecting the radio button.
  ///
  ///To disable the radio button, use the [isEnabled] property
  const DSRadioTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.groupValue,
    this.isEnabled = true,
    this.contentPadding,
  }) : super(key: key);

  /// Clickable radio group title allowing you to select an option.
  final String? title;

  /// Determines the grouping of buttons allowing one of them to be selected
  ///
  /// The <T> type determines which type of variable to use as [value],
  /// which can be int, String, or even an object.
  final T? groupValue;

  /// Allows you to enable or disable the use of the button group, setting a
  /// default value and preventing other options from being returned.
  final bool isEnabled;

  /// Event that fires when an option within the group is changed.
  final ValueChanged<T?>? onChanged;

  /// Button value that will be returned when it is selected.
  final T value;

  /// Content spacing inner border size
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: isEnabled,
      dense: true,
      horizontalTitleGap: 0,
      onTap: () => onChanged!(value),
      leading: DSRadio(
        isEnabled: isEnabled,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      title: DSBodyText(text: title!),
      contentPadding: contentPadding,
    );
  }
}
