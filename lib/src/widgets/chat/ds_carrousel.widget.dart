import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../models/ds_document_select.model.dart';
import '../../models/ds_message_bubble_avatar_config.model.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../utils/ds_utils.util.dart';
import '../utils/ds_card.widget.dart';
import 'ds_image_message_bubble.widget.dart';

/// A Design System widget used to display multiple cards.
///
/// The widget receives a json passed by the [content] parameter and displays the information
/// in two ways according to the [itemType] parameter contained in the header.
/// If the [itemType] contains the select parameter, the content is displayed in carousel mode, and if it
/// contains the container parameter, it is displayed in a vertical line.
class DSCarrousel extends StatelessWidget {
  /// Sets the card's alignment on the screen.
  final DSAlign align;

  /// Json that defines the widget type and content
  final Map<String, dynamic> content;

  /// Card borders for design when used grouped
  final List<DSBorderRadius> borderRadius;

  /// Selection return callbacks in menus
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;

  // Avatar configuration
  final DSMessageBubbleAvatarConfig avatarConfig;

  /// Card styling to adjust custom colors
  final DSMessageBubbleStyle style;

  DSCarrousel({
    super.key,
    required this.align,
    required this.content,
    required this.borderRadius,
    this.onSelected,
    this.onOpenLink,
    this.avatarConfig = const DSMessageBubbleAvatarConfig(),
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    return _buildCollection();
  }

  Widget _buildCollection() {
    final children = <Widget>[];
    final String typeCollection;

    (content['itemType'].contains('select'))
        ? typeCollection = 'select'
        : typeCollection = 'container';

    final items = content['items'];

    for (final item in items) {
      if (typeCollection == 'select') {
        final Map<String, dynamic> header = item["header"];
        final List options = item["options"];

        final listOptions = <DSDocumentSelectOption>[];

        for (final option in options) {
          listOptions.add(DSDocumentSelectOption.fromJson(option));
        }

        children.add(
          SizedBox(
            width: DSUtils.bubbleMinSize,
            child: DSImageMessageBubble(
              align: align,
              url: header["value"]["uri"],
              title: header["value"]["title"],
              text: header["value"]["text"],
              appBarText: (align == DSAlign.left
                      ? avatarConfig.receivedName
                      : avatarConfig.sentName) ??
                  header["value"]["title"],
              appBarPhotoUri: align == DSAlign.left
                  ? avatarConfig.receivedAvatar
                  : avatarConfig.sentAvatar,
              selectOptions: listOptions,
              showSelect: true,
              hasSpacer: false,
              onSelected: onSelected,
              onOpenLink: onOpenLink,
              style: style,
              mediaType: header["value"]["type"],
            ),
          ),
        );
      } else {
        final contentContainer = item['value'];
        final index = items.indexOf(item);
        final radius = [DSBorderRadius.topLeft, DSBorderRadius.bottomLeft];

        if (index == 0 &&
            borderRadius.any((element) => [
                  DSBorderRadius.topRight,
                  DSBorderRadius.all
                ].any((border) => element == border))) {
          radius.add(DSBorderRadius.topRight);
        } else if (index == items.length - 1 &&
            borderRadius.any((element) => [
                  DSBorderRadius.bottomRight,
                  DSBorderRadius.all
                ].any((border) => element == border))) {
          radius.add(DSBorderRadius.bottomRight);
        }

        children.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: DSCard(
              type: item['type'],
              content: contentContainer,
              align: align,
              style: style,
              borderRadius: radius,
              avatarConfig: avatarConfig,
              onSelected: onSelected,
              onOpenLink: onOpenLink,
            ),
          ),
        );
      }
    }

    return typeCollection == 'select'
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: 16.0,
                alignment: WrapAlignment.start,
                children: children,
              ),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          );
  }
}
