import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/theme/systems_colors.dart';
import 'package:flutter/material.dart';

class DSTextMessageBubble extends StatefulWidget {
  final String text;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;

  const DSTextMessageBubble({
    Key? key,
    required this.text,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
  }) : super(key: key);

  @override
  State<DSTextMessageBubble> createState() => _DSTextMessageBubbleState();
}

class _DSTextMessageBubbleState extends State<DSTextMessageBubble> {
  bool _expandText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DSTextMessageBubble oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      _expandText = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: widget.align,
      borderRadius: widget.borderRadius,
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        curve: Curves.linearToEaseOut,
        duration: const Duration(milliseconds: 600),
        clipBehavior: Clip.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText(),
            if (_checkTextOverflow()) _buildShowMore(),
          ],
        ),
      ),
    );
  }

  Text _buildText() {
    return Text(
      widget.text,
      overflow: !_expandText ? TextOverflow.ellipsis : null,
      style: const TextStyle(
        color: SystemColors.neutralLightSnow,
      ),
    );
  }

  Widget _buildShowMore() {
    return GestureDetector(
      onTap: _showMoreOnTap,
      child: const Text(
        /// TODO: Need localized translate.
        'Mostrar mais',
        style: TextStyle(
          color: SystemColors.primaryLight,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  bool _checkTextOverflow() {
    return !_expandText && widget.text.length > 30;
  }

  void _showMoreOnTap() {
    setState(() {
      _expandText = true;
    });
  }
}
