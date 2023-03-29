import 'package:flutter/material.dart';

import '../../enums/ds_button_shape.enum.dart';
import '../animations/ds_animated_size.widget.dart';
import '../animations/ds_ring_loading.widget.dart';
import '../texts/ds_button_text.widget.dart';

const _kMinimumSize = Size(44.0, 44.0);

/// A container that has some default properties which should be extended by others Design System's [ButtonStyleButton].
class DSButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Widget? leadingIcon;
  final String? label;
  final Widget? trailingIcon;
  final bool isEnabled;
  final bool isLoading;
  final DSButtonShape shape;
  final bool autoSize;
  final MainAxisAlignment contentAlignment;

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
    this.shape = DSButtonShape.rectangular,
    this.autoSize = true,
    this.contentAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    _setContentList();

    return OutlinedButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: OutlinedButton.styleFrom(
        padding: shape == DSButtonShape.rounded
            ? const EdgeInsets.all(8.0)
            : EdgeInsets.symmetric(
                vertical: _isIconOnly() ? 8.0 : 10.0,
                horizontal: _isIconOnly() ? 10.0 : 16.0,
              ),
        minimumSize: _kMinimumSize,
        maximumSize: shape == DSButtonShape.rounded ? _kMinimumSize : null,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shape: shape == DSButtonShape.rounded
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
        side: BorderSide(
          color: borderColor ?? backgroundColor,
        ),
      ),
      child: DSAnimatedSize(
        child: Row(
          mainAxisAlignment: contentAlignment,
          mainAxisSize: autoSize ? MainAxisSize.min : MainAxisSize.max,
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
            label!,
            color: foregroundColor,
            textAlign: TextAlign.center,
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
          padding: EdgeInsets.only(
            right: 4.0,
          ),
        ),
      );
    }
  }
}
