import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../models/ds_active_message.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/icons/ds_icons.dart';
import '../chat/reply/ds_in_reply_content.widget.dart';
import '../texts/ds_body_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';

class DSActiveMessageContentReply extends StatelessWidget {
  DSActiveMessageContentReply({
    super.key,
    required this.activeMessage,
    required this.align,
    required this.foreground,
    this.simpleStyle = false,
    DSMessageBubbleStyle? style,
  }) : style = style ?? DSMessageBubbleStyle();

  final DSActiveMessage activeMessage;
  final DSAlign align;
  final Color foreground;
  final bool simpleStyle;
  final DSMessageBubbleStyle style;

  late final templateTitle =
      activeMessage.template?.name ?? 'unsupported-content.text'.translate();

  late final templateContent = _buildTemplateContent();

  String _buildTemplateContent() {
    var componentTemplateBody = activeMessage.templateContent?.components
        ?.where((component) => component['type'] == 'BODY')
        .toList();
    var bodyFilledVariables = activeMessage.template?.components
        ?.where((component) => component['type'] == 'body')
        .toList();

    String? content;

    if (componentTemplateBody?.isNotEmpty ?? false) {
      content = componentTemplateBody?[0]['text'] ?? '';

      if (bodyFilledVariables?.isNotEmpty ?? false) {
        final params = bodyFilledVariables?[0]['parameters'];

        final regexFindVariablesInText = RegExp(r'/\{\{(\d+)\}\}/g');

        var index = 1;
        content = content?.replaceAllMapped(regexFindVariablesInText, (match) {
          final variable = params[index - 1];
          return variable && variable.text ? variable.text : match;
        });
      }
    }

    // componentTemplateBody = this.sanitize(componentTemplateBody)

    return content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return DSInReplyContent(
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
        ),
        child: Icon(
          DSIcons.paperplane_outline,
          color: foreground,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!simpleStyle)
            DSCaptionText(
              templateTitle,
              color: foreground,
            ),
          DSBodyText(
            templateContent,
            color: foreground,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
