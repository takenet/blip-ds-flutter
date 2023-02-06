import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

class SampleCollectionShowcase extends StatelessWidget {
  const SampleCollectionShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentSelect = selectJson['content'] as Map<String, dynamic>;
    final contentContainer = containerJson['content'] as Map<String, dynamic>;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 40.0),
        const Center(
          child: Text('Collection Carrousel'),
        ),
        DSCarrousel(
          align: DSAlign.left,
          content: contentSelect,
          borderRadius: const [DSBorderRadius.all],
          onOpenLink: (dynamic payload) {
            debugPrint('Infos de callback: / $payload');
          },
          onSelected: (String text, dynamic payload) {
            debugPrint('Infos de callback: $text / $payload');
          },
        ),
        const SizedBox(height: 40.0),
        const Center(
          child: Text('Collection Container'),
        ),
        DSCarrousel(
          align: DSAlign.right,
          content: contentContainer,
          borderRadius: const [DSBorderRadius.all],
          onOpenLink: (dynamic payload) {
            debugPrint('Infos de callback: / $payload');
          },
          onSelected: (String text, dynamic payload) {
            debugPrint('Infos de callback: $text / $payload');
          },
        ),
      ],
    );
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
                "text": "Weblink",
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
      },
      {
        "type": "application/vnd.lime.media-link+json",
        "value": {
          "text": "Welcome to our store!",
          "type": "video/mp4",
          "uri":
              "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
        }
      },
      {
        "type": "application/vnd.lime.media-link+json",
        "value": {
          "text": "",
          "type": "audio/mpeg",
          "uri":
              "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"
        }
      },
      {
        "type": "application/vnd.lime.media-link+json",
        "value": {
          "size": 1203179,
          "text": "Legenda do pdf",
          "title": "teste.pdf",
          "type": "application/pdf",
          "uri":
              "https://download.brother.com/welcome/doc100107/cv_mfc4620dw_epr_busr_leu359065.pdf"
        }
      }
    ]
  }
};
