import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:get/get.dart';

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
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _shorText = lorem(
    words: 3,
    paragraphs: 1,
  );

  final _longText = lorem(
    words: 100,
    paragraphs: 1,
  );

  final RxString _sampleText = RxString('');

  final String _sampleAudio =
      'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3';

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blip Design System Showcase'),
      ),
      bottomNavigationBar: Container(
        color: SystemColors.neutralDarkCity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                onPressed: () => _sampleText.value = _shorText,
                child: const Text('Texto Curto'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _sampleText.value = _longText,
              child: const Text('Texto Longo'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => ListView(
            reverse: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DSTextMessageBubble(
                    text: _sampleText.value.isNotEmpty
                        ? _sampleText.value
                        : _shorText,
                    align: DSAlign.left,
                  ),
                  DSTextMessageBubble(
                    text: _sampleText.value.isNotEmpty
                        ? _sampleText.value
                        : _shorText,
                    align: DSAlign.right,
                  ),
                  DSAudioMessageBubble(align: DSAlign.left, uri: _sampleAudio),
                  DSAudioMessageBubble(align: DSAlign.right, uri: _sampleAudio),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
