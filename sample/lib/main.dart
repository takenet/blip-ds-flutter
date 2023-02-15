import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:sample/widgets/showcase/sample_bottom_sheet.showcase.dart';
import 'package:sample/widgets/showcase/sample_button.showcase.dart';
import 'package:sample/widgets/showcase/sample_collection.showcase.dart';
import 'package:sample/widgets/showcase/sample_dialog.showcase.dart';
import 'package:sample/widgets/showcase/sample_group_card.showcase.dart';
import 'package:sample/widgets/showcase/sample_header.showcase.dart';
import 'package:sample/widgets/showcase/sample_message_bubble.showcase.dart';
import 'package:sample/widgets/showcase/sample_radio.showcase.dart';
import 'package:sample/widgets/showcase/sample_switch.showcase.dart';
import 'package:sample/widgets/showcase/sample_text_style.showcase.dart';
import 'package:sample/widgets/showcase/sample_ticket_message.showcase.dart';
import 'package:sample/widgets/showcase/sample_toast.showcase.dart';
import 'package:sample/widgets/showcase/sample_typing.showcase.dart';

import 'package:blip_ds/blip_ds.dart';
import 'package:sample/widgets/showcase/sample_weblink.showcase.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blip Design System Showcase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const DSTextTheme(),
        textSelectionTheme: DSTextSelectionThemeData(),
        cupertinoOverrideTheme: const DSCupertinoThemeData(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DSHeader(
        title: 'Blip Design System Showcase',
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SampleMessageBubbleShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleTextStyleShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleButtonShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleTypingShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleSwitchShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleDialogShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleToastShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            SampleRadioShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            SampleGroupCardShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleHeaderShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleBottomSheethowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleTicketMessage(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleCollectionShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleWeblinkShowcase(),
          ],
        ),
      ),
    );
  }
}
