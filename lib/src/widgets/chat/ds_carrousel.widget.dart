// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:blip_ds/src/models/ds_document_select.model.dart';

import '../../../blip_ds.dart';
import '../utils/ds_card.widget.dart';

class DSCarrousel extends StatelessWidget {
  final DSAlign align;
  final Map<String, dynamic>? content;
  final void Function(String, Map<String, dynamic>)? onSelected;
  final void Function(Map<String, dynamic>)? onOpenLink;

  const DSCarrousel({
    Key? key,
    required this.align,
    this.content,
    this.onSelected,
    this.onOpenLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: _buildQuickReply(),
    );
  }

  Widget _buildQuickReply() {
    return _buildItems();
  }

  Widget _buildItems() {
    var children = <Widget>[];
    var typeCollection = '';

    // var content = selectJson['content'] as Map;
    var content = container['content'] as Map;

    (content['itemType'].contains('collection'))
        ? typeCollection = 'select'
        : typeCollection = 'container';

    List items = content['items'];

    for (var item in items) {
      ///
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
        content = item['value'] as Map;

        children.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: DSCard(
              type: item['type'],
              content: content,
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

const selectJson = {
  "id": "5",
  "to": "1042221589186385@messenger.gw.msging.net",
  "type": "application/vnd.lime.collection+json",
  "content": {
    "itemType": "application/vnd.lime.document-select+json",
    "items": [
      {
        "header": {
          "type": "application/vnd.lime.media-link+json",
          "value": {
            "title": "Title",
            "text": "This is a first item",
            "type": "image/jpeg",
            "uri":
                "http://www.isharearena.com/wp-content/uploads/2012/12/wallpaper-281049.jpg"
          }
        },
        "options": [
          {
            "label": {
              "type": "application/vnd.lime.web-link+json",
              "value": {
                "title": "Link",
                "uri": "https://server.com/first/link1"
              }
            }
          },
          {
            "label": {"type": "text/plain", "value": "Text 1"},
            "value": {
              "type": "application/json",
              "value": {"key1": "value1", "key2": 2}
            }
          }
        ]
      },
      {
        "header": {
          "type": "application/vnd.lime.media-link+json",
          "value": {
            "title": "Title 2",
            "text": "This is another item",
            "type": "image/jpeg",
            "uri":
                "http://www.freedigitalphotos.net/images/img/homepage/87357.jpg"
          }
        },
        "options": [
          {
            "label": {
              "type": "application/vnd.lime.web-link+json",
              "value": {
                "title": "Second link",
                "text": "Weblink",
                "uri": "https://server.com/second/link2"
              }
            }
          },
          {
            "label": {"type": "text/plain", "value": "Second text"},
            "value": {
              "type": "application/json",
              "value": {"key3": "value3", "key4": 4}
            }
          },
          {
            "label": {"type": "text/plain", "value": "More one text"},
            "value": {
              "type": "application/json",
              "value": {"key5": "value5", "key6": "6"}
            }
          }
        ]
      },
      {
        "header": {
          "type": "application/vnd.lime.media-link+json",
          "value": {
            "title": "Title 3",
            "text": "This is another item",
            "type": "image/jpeg",
            "uri":
                "http://www.freedigitalphotos.net/images/img/homepage/87357.jpg"
          }
        },
        "options": [
          {
            "label": {
              "type": "application/vnd.lime.web-link+json",
              "value": {
                "title": "Second link",
                "text": "Weblink",
                "uri": "https://server.com/second/link2"
              }
            }
          },
          {
            "label": {"type": "text/plain", "value": "Second text"},
            "value": {
              "type": "application/json",
              "value": {"key3": "value3", "key4": 4}
            }
          },
          {
            "label": {"type": "text/plain", "value": "More one text"},
            "value": {
              "type": "application/json",
              "value": {"key5": "value5", "key6": "6"}
            }
          }
        ]
      }
    ]
  }
};

const containerJson = {
  "id": "5",
  "to": "553199990000@0mn.io",
  "type": "application/vnd.lime.collection+json",
  "content": {
    "itemType": "application/vnd.lime.container+json",
    "items": [
      {
        "type": "application/vnd.lime.media-link+json",
        "value": {
          "text": "Welcome to our store!",
          "type": "image/jpeg",
          "uri":
              "http://2.bp.blogspot.com/-pATX0YgNSFs/VP-82AQKcuI/AAAAAAAALSU/Vet9e7Qsjjw/s1600/Cat-hd-wallpapers.jpg"
        }
      },
      {
        "type": "application/vnd.lime.select+json",
        "value": {
          "text": "Choose what you need",
          "options": [
            {"order": 1, "text": "See our stock"},
            {"order": 2, "text": "Follow an order"}
          ]
        }
      }
    ]
  }
};
