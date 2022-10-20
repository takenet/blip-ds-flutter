import 'package:flutter/material.dart';

import 'package:blip_ds/src/models/ds_document_select.model.dart';

import '../../../blip_ds.dart';
import '../utils/ds_card.widget.dart';

/// A Design System widget used to display multiple cards.
///
/// The widget receives a json passed by the [content] parameter and displays the information
/// in two ways according to the [itemType] parameter contained in the header.
/// If the [itemType] contains the select parameter, the content is displayed in carousel mode, and if it
/// contains the container parameter, it is displayed in a vertical line.
class DSCarrousel extends StatelessWidget {
  /// Sets the card's alignment on the screen.
  final DSAlign align;

  /// Widget content containing card parameters
  final Map<String, dynamic> content;

  /// Selection return callbacks in menus
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;

  const DSCarrousel({
    Key? key,
    required this.align,
    required this.content,
    this.onSelected,
    this.onOpenLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCollection();
  }

  Widget _buildCollection() {
    var children = <Widget>[];
    String typeCollection;
    List items;

    var contentSelect = content['content'];

    (contentSelect['itemType'].contains('select'))
        ? typeCollection = 'select'
        : typeCollection = 'container';

    items = contentSelect['items'];

    for (var item in items) {
      if (typeCollection == 'select') {
        Map<String, dynamic>? header = item["header"];
        List options = item["options"];

        var listOptions = <DSDocumentSelectOption>[];

        for (var option in options) {
          listOptions.add(DSDocumentSelectOption.fromJson(option));
        }

        children.add(
          SizedBox(
            width: DSUtils.bubbleMinSize,
            child: DSImageMessageBubble(
              align: align,
              url: header!["value"]["uri"],
              title: header["value"]["title"],
              text: header["value"]["text"],
              appBarText: header["value"]["title"],
              selectOptions: listOptions,
              showSelect: true,
              hasSpacer: false,
              onSelected: onSelected,
              onOpenLink: onOpenLink,
            ),
          ),
        );
      } else {
        var contentContainer = item['value'];

        children.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: DSCard(
              type: item['type'],
              content: contentContainer,
              align: align,
              borderRadius: const [DSBorderRadius.all],
              customerName: 'Jhon Doe',
              onSelected: onSelected,
              onOpenLink: onOpenLink,
            ),
          ),
        );
      }
    }

    if (typeCollection == 'select') {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 16.00,
            alignment: WrapAlignment.start,
            children: children,
          ),
        ),
      );
    } else {
      return Column(
        children: children,
      );
    }
  }
}
