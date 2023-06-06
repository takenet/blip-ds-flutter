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
    super.key,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

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
        Visibility(
          visible: widget.name != null,
          child: DSBodyText(
            widget.name,
            fontWeight: DSFontWeights.semiBold,
          ),
        ),
        const SizedBox(height: 16.0),
        Visibility(
          visible: widget.phone != null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: _buildContactField(
              title: 'Telefone',
              body: widget.phone!,
            ),
          ),
        ),
        Visibility(
          visible: widget.email != null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: _buildContactField(
              title: 'E-mail',
              body: widget.email!,
            ),
          ),
        ),
        Visibility(
          visible: widget.address != null,
          child: _buildContactField(
            title: 'Endereço',
            body: widget.address!,
          ),
        ),
      ],
    );
  }

  Widget _buildContactField({
    required final String title,
    required final String body,
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
