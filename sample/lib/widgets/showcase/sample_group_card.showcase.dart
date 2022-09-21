import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:sample/controllers/sample_group_card.controller.dart';

class SampleGroupCardShowcase extends StatelessWidget {
  final SampleGroupCardController _controller;

  SampleGroupCardShowcase({super.key})
      : _controller = SampleGroupCardController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSBodyText(text: 'DS group card'),
        FutureBuilder(
          future: _controller.getMessages(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return DSGroupCard(
                onOpenLink: (dynamic payload) {
                  print('Infos de callback: $payload');
                },
                onSelected: (String text, dynamic payload) {
                  print('Infos de callback: $text / $payload');
                },
                isComposing: false,
                documents: snapshot.data as List<DSMessageItemModel>,
                compareMessages: (DSMessageItemModel firstMsg,
                    DSMessageItemModel secondMsg) {
                  bool shouldGroupSelect = true;

                  if (firstMsg.type == 'application/vnd.lime.select+json' ||
                      secondMsg.type == 'application/vnd.lime.select+json') {
                    if (firstMsg.content is Map &&
                            firstMsg.content['scope'] == 'immediate' ||
                        secondMsg.content is Map &&
                            secondMsg.content['scope'] == 'immediate') {
                      shouldGroupSelect = false;
                    }
                  }

                  return (DateTime.parse(firstMsg.date)
                              .difference(DateTime.parse(secondMsg.date))
                              .inSeconds <=
                          60 &&
                      firstMsg.status == secondMsg.status &&
                      firstMsg.align == secondMsg.align &&
                      shouldGroupSelect);
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
