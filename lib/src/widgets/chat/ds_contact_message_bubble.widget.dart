import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSContactMessageBubble extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;

  DSContactMessageBubble({
    Key? key,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

  @override
  State<DSContactMessageBubble> createState() => _DSContactMessageBubbleState();
}

class _DSContactMessageBubbleState extends State<DSContactMessageBubble> {
  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: widget.align,
      borderRadius: widget.borderRadius,
      padding: const EdgeInsets.all(16.0),
      style: widget.style,
      hasSpacer: true,
      child: _buildContactCard(),
    );
  }

  Widget _buildContactCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.name != null)
          DSBodyText(
            widget.name,
            fontWeight: DSFontWeights.semiBold,
          ),
        const SizedBox(height: 16.0),
        if (widget.phone != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: _buildContactField(
              title: 'Telefone',
              body: widget.phone!,
            ),
          ),
        if (widget.email != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: _buildContactField(
              title: 'E-mail',
              body: widget.email!,
            ),
          ),
        if (widget.address != null)
          _buildContactField(
            title: 'Endereço',
            body: widget.address!,
          ),
      ],
    );
  }

  Widget _buildContactField({
    required String title,
    required String body,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSCaptionSmallText(title),
        DSBodyText(
          body,
          shouldLinkify: false,
        ),
      ],
    );
  }
}
