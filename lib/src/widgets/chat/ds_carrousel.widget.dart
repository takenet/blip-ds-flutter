import 'package:flutter/material.dart';

import '../../../blip_ds.dart';
import '../../models/ds_document_select.model.dart';
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

  /// Json that defines the widget type and content
  final Map<String, dynamic> content;

  /// TODO: add border radius description
  final List<DSBorderRadius> borderRadius;

  /// Selection return callbacks in menus
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;

  const DSCarrousel({
    Key? key,
    required this.align,
    required this.content,
    required this.borderRadius,
    this.onSelected,
    this.onOpenLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCollection();
  }

  Widget _buildCollection() {
    var children = <Widget>[];
    var typeCollection = '';
    var items = [];

    var contentSelect = content;

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
              borderRadius: radius,
              customerName: contentContainer['text'],
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
              child: Wrap(
                spacing: 16.00,
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
