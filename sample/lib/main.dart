import 'dart:convert';

import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:sample/widgets/showcase/sample_user_avatar.showcase.dart';

import 'widgets/showcase/sample_bottom_sheet.showcase.dart';
import 'widgets/showcase/sample_button.showcase.dart';
import 'widgets/showcase/sample_collection.showcase.dart';
import 'widgets/showcase/sample_dialog.showcase.dart';
import 'widgets/showcase/sample_group_card.showcase.dart';
import 'widgets/showcase/sample_header.showcase.dart';
import 'widgets/showcase/sample_input.showcase.dart';
import 'widgets/showcase/sample_message_bubble.showcase.dart';
import 'widgets/showcase/sample_radio.showcase.dart';
import 'widgets/showcase/sample_switch.showcase.dart';
import 'widgets/showcase/sample_text_style.showcase.dart';
import 'widgets/showcase/sample_ticket_message.showcase.dart';
import 'widgets/showcase/sample_toast.showcase.dart';
import 'widgets/showcase/sample_typing.showcase.dart';
import 'widgets/showcase/sample_weblink.showcase.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<String> _translations;

  @override
  void initState() {
    super.initState();
    _translations = rootBundle.loadString('assets/ds_localization.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(
        title: 'Blip Design System Showcase',
      ),
      body: FutureBuilder<String>(
          future: _translations,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              DSLocalizationService.setTranslations(jsonDecode(snapshot.data!));
              DSLocalizationService.setLocale(const Locale('pt', 'BR'));
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const SampleUserAvatarShowcase(),
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
                    const SampleBottomSheetShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                    const SampleTicketMessage(),
                    const Divider(color: DSColors.neutralDarkCity),
                    const SampleCollectionShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                    const SampleWeblinkShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                    SampleInputShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
