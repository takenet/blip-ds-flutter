import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

/// A container that has some default properties which should be extended by others Design System's [ButtonStyleButton].
class DSButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Icon? leadingIcon;
  final String? label;
  final Icon? trailingIcon;
  final bool isEnabled;
  final bool isLoading;

  final List<Widget> _contentList = [];

  /// Creates a Design System's [ButtonStyleButton].
  ///
  /// Set [isEnabled] to activate/deactivate this button's [onPressed] and change his style.
  /// Set [isLoading] to override content with a loading animation. It also deactivates [onPressed].
  DSButton({
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
    this.leadingIcon,
    this.label,
    this.trailingIcon,
    this.borderColor,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    _setContentList();

    return OutlinedButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: _isIconOnly() ? 8.0 : 10.0,
          horizontal: _isIconOnly() ? 10.0 : 16.0,
        ),
        minimumSize: const Size(
          44.0,
          44.0,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: BorderSide(
          color: borderColor ?? backgroundColor,
        ),
      ),
      child: DSAnimatedSize(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _contentList,
        ),
      ),
    );
  }

  void _setContentList() {
    _contentList.clear();

    if (isLoading) {
      _addLoading();
    } else {
      _addLeadingIcon();
      _addLabel();
      _addTrailingIcon();
    }

    _insertPaddingBetweenElements();
  }

  void _addLoading() {
    _contentList.add(
      DSRingLoading(
        color: foregroundColor,
      ),
    );
  }

  void _addLeadingIcon() {
    if (leadingIcon != null) {
      _contentList.add(leadingIcon!);
    }
  }

  void _addLabel() {
    if (label != null) {
      _contentList.add(
        Flexible(
          child: DSButtonText(
            text: label!,
            color: foregroundColor,
          ),
        ),
      );
    }
  }

  void _addTrailingIcon() {
    if (trailingIcon != null) {
      _contentList.add(trailingIcon!);
    }
  }

  bool _isIconOnly() {
    final bool hasIcon = (leadingIcon != null || trailingIcon != null);

    return _contentList.length == 1 && hasIcon;
  }

  void _insertPaddingBetweenElements() {
    for (int i = 1; i < _contentList.length; i += 2) {
      _contentList.insert(
        i,
        const Padding(
          padding: EdgeInsets.only(right: 6.0),
        ),
      );
    }
  }
}
