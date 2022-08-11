import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:sample/widgets/showcase/sample_dialog.showcase.dart';
import 'package:sample/widgets/showcase/sample_message_bubble_showcase.dart';
import 'package:sample/widgets/showcase/sample_text_style_showcase.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blip Design System Showcase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const DSTextTheme(),
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
      appBar: AppBar(
        title: const Text('Blip Design System Showcase'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SampleMessageBubbleShowcase(),
            const Divider(color: DSColors.neutralDarkCity),
            const SampleTextStyleShowcase(),
            const SampleDialogShowcase(),
          ],
        ),
      ),
    );
  }
}
