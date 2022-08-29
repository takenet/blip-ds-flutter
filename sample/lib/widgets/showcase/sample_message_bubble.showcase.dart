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
    "https://file-examples.com/wp-content/uploads/2018/04/file_example_MOV_1920_2_2MB.mov",
    "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-avi-file.avi",
    "https://www.gov.br/agricultura/pt-br/assuntos/sustentabilidade/cesesp/audios/boletim-para-protecao-a-covid-19-no-campo-03.mpeg",
    "https://ia800302.us.archive.org/8/items/RandomForumVimeoShow-FinalTestResultswidescreenTest/FinalTestResults.ogv",
    "https://filesamples.com/samples/video/wmv/sample_960x400_ocean_with_audio.wmv",
    "https://file-examples.com/storage/fe8bd9dfd063066d39cfd5a/2020/03/file_example_WEBM_480_900KB.webm",
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];

  SampleMessageBubbleShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
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
            align: DSAlign.left,
            url: _sampleImage,
            imageTitle: 'imageTitle.png',
            imageText: 'My picture',
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
            groupWithPreviousMessage: true,
          ),
          DSTextMessageBubble(
            text: _sampleText.value.isNotEmpty ? _sampleText.value : _shorText,
            align: DSAlign.right,
            borderRadius: const [
              DSBorderRadius.topLeft,
              DSBorderRadius.bottomLeft,
              DSBorderRadius.bottomRight,
            ],
            groupWithPreviousMessage: true,
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
            urlVideo: '',
            urlThumbnail: '',
            videoTitle: 'imageTitle.png',
            imageText: 'My picture',
            appBarText: 'Unknown User',
          ),
          DSVideoMessageBubble(
            align: DSAlign.left,
            urlVideo: _srcsVideo[8],
            urlThumbnail: _sampleImage,
            videoTitle: 'imageTitle.png',
            imageText: 'My picture',
            appBarText: 'Unknown User',
          ),

          ///
          ///
        ],
      ),
    );
  }
}
