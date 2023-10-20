import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSContactMessageBubble extends StatelessWidget {
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? replyId;
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
    this.replyId,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      padding: const EdgeInsets.all(16.0),
      shouldUseDefaultSize: true,
      style: style,
      replyId: replyId,
      child: _buildContactCard(),
    );
  }

  Widget _buildContactCard() {
    final foregroundColor = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: name != null,
          child: DSBodyText(
            name,
            fontWeight: DSFontWeights.semiBold,
            color: foregroundColor,
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(height: 16.0),
        /// TODO(format): Format phone number
        if (phone != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: _buildContactField(
                title: 'Telefone',
                body: phone!,
                foregroundColor: foregroundColor),
          ),
        if (email != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: _buildContactField(
                title: 'E-mail',
                body: email!,
                foregroundColor: foregroundColor),
          ),
        if (address != null)
          _buildContactField(
            title: 'Endereço',
            body: address!,
            foregroundColor: foregroundColor,
          ),
      ],
    );
  }

  Widget _buildContactField({
    required final String title,
    required final String body,
    required final Color foregroundColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSCaptionSmallText(
          title,
          color: foregroundColor,
        ),
        DSBodyText(
          body,
          shouldLinkify: false,
          color: foregroundColor,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}
