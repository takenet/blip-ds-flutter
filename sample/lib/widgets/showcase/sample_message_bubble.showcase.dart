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

  final Map<String, String> _sampleImages = {
    "extraSmall": 'https://cdn-icons-png.flaticon.com/128/6913/6913220.png',
    'small':
        'https://media-exp1.licdn.com/dms/image/C4D0BAQFjHCo7bQdJzw/company-logo_200_200/0/1573068688534?e=2147483647&v=beta&t=WqHR7Fd2aliRvwBxxOUpK71IITtyI1TFsDpsaYi3xug',
    'medium':
        'https://smaller-pictures.appspot.com/images/dreamstime_xxl_65780868_small.jpg',
    'large':
        'https://i.postimg.cc/mrrPH9ww/Simulator-Screen-Shot-i-Phone-13-2022-09-09-at-10-50-37.png',
    'extraLarge':
        'https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg?w=2000',
  };

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
            imageTitle: 'imageTitle.png',
            imageText: 'My picture',
            appBarText: 'Unknown User',
          ),
          DSImageMessageBubble(
            align: DSAlign.right,
            url: _sampleImages['medium']!,
            imageTitle: '512x512.png',
            imageText: _longText,
            appBarText: 'Unknown User',
          ),
          DSImageMessageBubble(
            align: DSAlign.right,
            url: _sampleImages['small']!,
            imageTitle: '200x200.png',
            imageText: _longText,
            appBarText: 'Unknown User',
          ),
          DSImageMessageBubble(
            align: DSAlign.right,
            url: _sampleImages['extraLarge']!,
            imageTitle: '2000x1330.png',
            imageText: _longText,
            appBarText: 'Unknown User',
          ),
          DSImageMessageBubble(
            align: DSAlign.right,
            url: _sampleImages['extraSmall']!,
            imageTitle: '128x128.png',
            imageText: _longText,
            appBarText: 'Unknown User',
          ),
          DSImageMessageBubble(
            align: DSAlign.right,
            url: _sampleImages['large']!,
            imageTitle: '1170×2532.png',
            imageText: 'Print',
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
        ],
      ),
    );
  }
}
