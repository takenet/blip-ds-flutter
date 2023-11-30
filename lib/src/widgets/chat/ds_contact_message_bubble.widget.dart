import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../models/ds_reply_content.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_small_text.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSContactMessageBubble extends StatelessWidget {
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final DSReplyContent? replyContent;
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
    this.replyContent,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      shouldUseDefaultSize: true,
      style: style,
      replyContent: replyContent,
      child: _buildContactCard(),
    );
  }

  Widget _buildContactCard() {
    final foregroundColor = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Column(
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
      ),
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
