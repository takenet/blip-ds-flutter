import 'package:blip_ds/src/widgets/loading/ds_ring_loading.widget.dart';
import 'package:blip_ds/src/widgets/texts/ds_button_text.widget.dart';
import 'package:flutter/material.dart';

class DSButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Icon? leadingIcon;
  final String? label;
  final Icon? trailingIcon;
  final bool disable;
  final bool loading;

  final List<Widget> _contentList = [];

  DSButton({
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
    this.leadingIcon,
    this.label,
    this.trailingIcon,
    this.borderColor,
    this.disable = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: foregroundColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: borderColor ?? backgroundColor,
        ),
      ),
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    _contentList.clear();

    if (loading) {
      _addLoading();
    } else {
      _addLeadingIcon();
      _addLabel();
      _addTrailingIcon();
    }

    _insertPaddingBetweenElements();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _contentList,
    );
  }

  void _addLoading() {
    _contentList.add(
      DSRingLoadingWidget(
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
        DSButtonText(
          text: label!,
          color: foregroundColor,
        ),
      );
    }
  }

  void _addTrailingIcon() {
    if (trailingIcon != null) {
      _contentList.add(trailingIcon!);
    }
  }

  void _insertPaddingBetweenElements() {
    for (int i = 1; i < _contentList.length; i += 2) {
      _contentList.insert(
        i,
        const Padding(
          padding: EdgeInsets.only(right: 10),
        ),
      );
    }
  }
}
