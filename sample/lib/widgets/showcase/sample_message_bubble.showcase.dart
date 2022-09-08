import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SampleMessageBubbleShowcase extends StatelessWidget {
  final String _shorText = lorem(
    words: 3,
    paragraphs: 1,
  );

  final String _longText = lorem(
    words: 100,
    paragraphs: 1,
  );

  final RxString _sampleText = RxString('');
  final String _sampleAudio =
      'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3';
  final String _sampleImage = 'https://picsum.photos/250?image=9';

  final List<String> _srcsVideo = [
    "https://filesamples.com/samples/video/mov/sample_960x400_ocean_with_audio.mov",
    "https://filesamples.com/samples/video/avi/sample_960x400_ocean_with_audio.avi",
    "https://filesamples.com/samples/video/mpeg/sample_960x400_ocean_with_audio.mpeg",
    "https://filesamples.com/samples/video/mpg/sample_960x400_ocean_with_audio.mpg",
    "https://filesamples.com/samples/video/ogv/sample_960x400_ocean_with_audio.ogv",
    "https://filesamples.com/samples/video/mkv/sample_960x400_ocean_with_audio.mkv",
    "https://filesamples.com/samples/video/wmv/sample_960x400_ocean_with_audio.wmv",
    "https://filesamples.com/samples/video/webm/sample_960x400_ocean_with_audio.webm",
    "https://filesamples.com/samples/video/3gp/sample_960x400_ocean_with_audio.3gp",
    "https://filesamples.com/samples/video/mp4/sample_960x400_ocean_with_audio.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4",
  ];

  SampleMessageBubbleShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const DSTextMessageBubble(
            text:
                'Exemplo de preview completo e borda "reta": https://www.take.net/',
            align: DSAlign.right,
            borderRadius: [
              DSBorderRadius.bottomLeft,
              DSBorderRadius.topLeft,
            ],
          ),
          const DSTextMessageBubble(
            text: 'Exemplo de preview completo: https://www.take.net/',
            align: DSAlign.left,
          ),
          const DSTextMessageBubble(
            text: 'Exemplo de preview simples: https://www.google.com.br/',
            align: DSAlign.right,
          ),
          const DSTextMessageBubble(
            text: 'Exemplo de URL inválido: https://www.google.c.br/',
            align: DSAlign.left,
          ),
          const DSTextMessageBubble(
            text:
                'Exemplo de preview sem info: https://www.ledr.com/colours/cyan.htm',
            align: DSAlign.right,
          ),
          const DSTextMessageBubble(
            text:
                'Lista de URLs:\n- https://www.take.net/\n- https://www.google.com.br/\n- https://pub.dev/packages/linkify',
            align: DSAlign.left,
          ),
          const DSTextMessageBubble(
            text:
                'Texto antes do link https://pub.dev/packages/linkify e texto depois do link!',
            align: DSAlign.right,
          ),
          DSFileMessageBubble(
              align: DSAlign.left,
              filename: 'teste.pdf',
              size: 10000,
              url:
                  'https://download.brother.com/welcome/doc100107/cv_mfc4620dw_epr_busr_leu359065.pdf'),
          DSFileMessageBubble(
              align: DSAlign.right,
              filename: 'master.zip',
              size: 500,
              url:
                  'https://github.com/takenet/blip-cards-vue-components/archive/refs/heads/master.zip'),
          const DSUnsupportedContentMessageBubble(
            align: DSAlign.left,
          ),
          const DSUnsupportedContentMessageBubble(
            align: DSAlign.right,
          ),
          DSImageMessageBubble(
            align: DSAlign.right,
            url: '',
            title: 'Hello',
            text: 'My picture',
            appBarText: 'Unknown User',
          ),
          DSImageMessageBubble(
            align: DSAlign.left,
            url: _sampleImage,
            text: 'My picture',
            appBarText: 'Unknown User',
          ),
          DSTextMessageBubble(
            text: _sampleText.value.isNotEmpty ? _sampleText.value : _shorText,
            align: DSAlign.left,
          ),
          DSTextMessageBubble(
            text: _sampleText.value.isNotEmpty ? _sampleText.value : _shorText,
            align: DSAlign.right,
            borderRadius: const [
              DSBorderRadius.topLeft,
              DSBorderRadius.bottomLeft,
              DSBorderRadius.topRight,
            ],
          ),
          DSTextMessageBubble(
            text: _sampleText.value.isNotEmpty ? _sampleText.value : _shorText,
            align: DSAlign.right,
            borderRadius: const [
              DSBorderRadius.topLeft,
              DSBorderRadius.bottomLeft,
            ],
          ),
          DSTextMessageBubble(
            text: _sampleText.value.isNotEmpty ? _sampleText.value : _shorText,
            align: DSAlign.right,
            borderRadius: const [
              DSBorderRadius.topLeft,
              DSBorderRadius.bottomLeft,
              DSBorderRadius.bottomRight,
            ],
          ),
          DSTextMessageBubble(
            text: _sampleText.value.isNotEmpty ? _sampleText.value : _shorText,
            align: DSAlign.right,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DSPrimaryButton(
                    onPressed: () => _sampleText.value = _shorText,
                    label: 'Texto Curto',
                  ),
                ),
                DSPrimaryButton(
                  onPressed: () => _sampleText.value = _longText,
                  label: 'Texto Longo',
                ),
              ],
            ),
          ),
          DSAudioMessageBubble(
            align: DSAlign.left,
            uri: _sampleAudio,
          ),
          DSAudioMessageBubble(
            align: DSAlign.right,
            uri: _sampleAudio,
          ),

          ///
          ///
          DSVideoMessageBubble(
            align: DSAlign.right,
            url: _srcsVideo[6],
            text: 'Olá Tudo bem?',
            appBarText: 'Unknown User',
          ),
          DSVideoMessageBubble(
            align: DSAlign.left,
            url: _srcsVideo[9],
            text: 'Se liga nesse vídeo!!',
            appBarText: 'Unknown User',
          ),
          DSVideoMessageBubble(
            align: DSAlign.right,
            url: _srcsVideo[11],
            text: 'Olá Tudo bem?',
            appBarText: 'Unknown User',
          ),

          ///
          ///
        ],
      ),
    );
  }
}
