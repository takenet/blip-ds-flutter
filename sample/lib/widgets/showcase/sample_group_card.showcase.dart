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
                isComposing: false,
                documents: snapshot.data as List<DSMessageItemModel>,
                compareMessages: (firstMsg, secondMsg) {
                  return (DateTime.parse(firstMsg.date)
                                  .difference(DateTime.parse(secondMsg.date))
                                  .inSeconds <=
                              60 &&
                          firstMsg.status == secondMsg.status &&
                          firstMsg.align == secondMsg.align)
                      ? true
                      : false;
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
