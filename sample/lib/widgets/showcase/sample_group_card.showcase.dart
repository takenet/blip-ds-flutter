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
        DSBodyText('DS group card'),
        FutureBuilder(
          future: _controller.getMessages(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return DSGroupCard(
                shrinkWrap: true,
                onOpenLink: (dynamic payload) {
                  print('Infos de callback: / $payload');
                },
                onSelected: (String text, dynamic payload) {
                  print('Infos de callback: $text / $payload');
                },
                isComposing: false,
                documents: snapshot.data as List<DSMessageItemModel>,
                style: DSMessageBubbleStyle(
                  sentBackgroundColor: DSColors.neutralLightSnow,
                  receivedBackgroundColor: const Color(0xff02afff),
                  pageBackgroundColor: const Color(0xffefefef),
                ),
                avatarConfig: const DSMessageBubbleAvatarConfig(
                  ownerName: 'Owner',
                  userName: 'User',
                ),
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
