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
      'https://filesamples.com/samples/video/webm/sample_640x360.webm';

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

  Future<String?> _onAsyncFetchSession(_) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => _sampleAudio,
    );
  }

  Future<String?> _onAsyncFetchEmptySession(_) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => null,
    );
  }

  Future<String?> _onAsyncFetchSessionError(_) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => throw UnimplementedError(),
    );
  }

  final _callsMediaMessage = {
    "sessionId": "346b4783-2c8e-4b08-a71f-01904a3c40f3",
    "type": "voice",
    "provider": "whatsapp",
    "direction": "inbound",
    "status": "completed",
    "ticketId": "ticketId",
    "identification": "5548999999999",
    "callDuration": 60,
  };

  final _callsMediaMessageError = {
    "sessionId": "346b4783-2c8e-4b08-a71f-01904a3c40f3",
    "type": "voice",
    "provider": "whatsapp",
    "direction": "inbound",
    "ticketId": "ticketId",
    "identification": "5548999999999",
    "callDuration": 0,
    "status": "noanswer",
  };

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          DSEndCallsMessageBubble(
            callsMediaMessage: DSCallsMediaMessage.fromJson(_callsMediaMessage),
            onAsyncFetchSession: _onAsyncFetchSession,
            align: DSAlign.right,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DSEndCallsMessageBubble(
              callsMediaMessage:
                  DSCallsMediaMessage.fromJson(_callsMediaMessage),
              onAsyncFetchSession: _onAsyncFetchEmptySession,
              align: DSAlign.right,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DSEndCallsMessageBubble(
              callsMediaMessage:
                  DSCallsMediaMessage.fromJson(_callsMediaMessage),
              onAsyncFetchSession: _onAsyncFetchSessionError,
              align: DSAlign.right,
            ),
          ),
          DSEndCallsMessageBubble(
            callsMediaMessage:
                DSCallsMediaMessage.fromJson(_callsMediaMessageError),
            onAsyncFetchSession: null,
            align: DSAlign.right,
          ),
          DSEndCallsMessageBubble(
            callsMediaMessage: DSCallsMediaMessage.fromJson(_callsMediaMessage),
            onAsyncFetchSession: _onAsyncFetchSession,
            align: DSAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DSEndCallsMessageBubble(
              callsMediaMessage:
                  DSCallsMediaMessage.fromJson(_callsMediaMessage),
              onAsyncFetchSession: _onAsyncFetchSessionError,
              align: DSAlign.left,
            ),
          ),
          DSEndCallsMessageBubble(
            callsMediaMessage:
                DSCallsMediaMessage.fromJson(_callsMediaMessageError),
            onAsyncFetchSession: null,
            align: DSAlign.left,
          ),
          DSTextMessageBubble(
            text: 'Essa foto é linda',
            align: DSAlign.left,
            replyContent: DSReplyContent(
              replied: DSReplyContentReplied(
                type: 'text/plain',
                value: 'Essa foto é linda',
              ),
              inReplyTo: DSReplyContentInReplyTo(
                id: 'id',
                type: 'application/vnd.lime.media-link+json',
                value:
                    '{uri:${_sampleImages['extraLarge']!}, type: "image/jpeg"}',
                direction: 'received',
              ),
            ),
          ),
          DSTextMessageBubble(
            text: 'Sim',
            align: DSAlign.left,
            replyContent: DSReplyContent(
              replied: DSReplyContentReplied(
                type: 'text/plain',
                value: 'Sim',
              ),
              inReplyTo: DSReplyContentInReplyTo(
                id: 'id',
                type: 'text/plain',
                value: 'Você gostaria de um atendimento humano?',
                direction: 'received',
              ),
            ),
          ),
          DSImageMessageBubble(
            align: DSAlign.left,
            url: _sampleImages['extraLarge']!,
            appBarText: 'appBarText',
            replyContent: DSReplyContent(
              replied: DSReplyContentReplied(
                type: 'text/plain',
                value:
                    '{type: "image/jpeg", uri: ${_sampleImages['extraLarge']!}}',
              ),
              inReplyTo: DSReplyContentInReplyTo(
                id: 'id',
                type: 'text/plain',
                value: 'Envie a imagem por favor',
                direction: 'received',
              ),
            ),
          ),
          DSApplicationJsonMessageBubble(
            align: DSAlign.right,
            borderRadius: const [
              DSBorderRadius.all,
              // DSBorderRadius.topLeft,
              // DSBorderRadius.bottomLeft,
              // DSBorderRadius.bottomRight,
              // DSBorderRadius.topRight,
            ],
            content: const {
              "recipient_type": "individual",
              "type": "interactive",
              "interactive": {
                "type": "button",
                "header": {
                  "text": "Cabeçalho",
                  "type": "video",
                  "video": {
                    "link":
                        "http://techslides.com/demos/sample-videos/small.mp4"
                  }
                },
                "body": {"text": "Selecione qual é o seu interesse:"},
                "action": {
                  "buttons": [
                    {
                      "reply": {"title": "Título do Botão"}
                    }
                  ]
                },
                "footer": {
                  "text": "Clique no botão abaixo para selecionar uma opção"
                }
              }
            },
          ),
          DSApplicationJsonMessageBubble(
            align: DSAlign.right,
            borderRadius: const [DSBorderRadius.all],
            content: const {
              "recipient_type": "individual",
              "type": "interactive",
              "interactive": {
                "type": "button",
                "header": {
                  "type": "text",
                  "text": "Cabeçalho",
                },
                "body": {"text": "Você já é nosso cliente?"},
                "action": {
                  "buttons": [
                    {
                      "type": "reply",
                      "reply": {"id": "1", "title": "Sim"}
                    },
                    {
                      "type": "reply",
                      "reply": {"id": "2", "title": "Não"}
                    }
                  ]
                },
                "footer": {"text": "Selecione uma opção abaixo"}
              }
            },
          ),
          DSApplicationJsonMessageBubble(
            align: DSAlign.left,
            borderRadius: const [DSBorderRadius.all],
            content: const {
              "recipient_type": "individual",
              "type": "interactive",
              "interactive": {
                "type": "list",
                "header": {
                  "text": "Cabeçalho",
                },
                "body": {
                  "text":
                      "Tenho mais algumas perguntas, mas prometo que vamos ser agéis. Gostaríamos de saber: Em qual segmento sua empresa atua? Essa informação nos ajudará a direcioná-lo para o atendimento ideal."
                },
                "action": {
                  "button": "Selecione uma opção",
                  "sections": [
                    {
                      "rows": [
                        {"id": "1", "title": "Esq. de Alumínio"},
                        {"id": "2", "title": "Vidraceiro"},
                        {"id": "3", "title": "Distribuidor"},
                        {"id": "4", "title": "Sistemista"},
                        {"id": "5", "title": "Soluções"},
                        {"id": "6", "title": "Outros"}
                      ]
                    }
                  ]
                },
                "footer": {
                  "text": "Clique no botão abaixo para selecionar uma opção"
                }
              }
            },
          ),
          DSApplicationJsonMessageBubble(
            align: DSAlign.left,
            borderRadius: const [DSBorderRadius.all],
            content: const {
              "recipient_type": "individual",
              "type": "interactive",
              "interactive": {
                "type": "list",
                "body": {
                  "text":
                      "Tenho mais algumas perguntas, mas prometo que vamos ser agéis. Gostaríamos de saber: Em qual segmento sua empresa atua? Essa informação nos ajudará a direcioná-lo para o atendimento ideal."
                },
                "action": {
                  "button": "Selecione uma opção",
                  "sections": [
                    {
                      "rows": [
                        {"id": "1", "title": "Esq. de Alumínio"},
                        {"id": "2", "title": "Vidraceiro"},
                        {"id": "3", "title": "Distribuidor"},
                        {"id": "4", "title": "Sistemista"},
                        {"id": "5", "title": "Soluções"},
                        {"id": "6", "title": "Outros"}
                      ]
                    }
                  ]
                },
                "footer": {
                  "text": "Clique no botão abaixo para selecionar uma opção"
                }
              }
            },
          ),
          DSApplicationJsonMessageBubble(
            align: DSAlign.right,
            borderRadius: const [DSBorderRadius.all],
            content: const {
              "recipient_type": "individual",
              "type": "interactive",
              "interactive": {
                "type": "list",
                "body": {"text": "Selecione qual é o seu interesse:"},
                "action": {
                  "button": "Selecione uma opção",
                  "sections": [
                    {
                      "title": "Título da Seção",
                      "rows": [
                        {"id": "1", "title": "Casas de Festas"},
                        {"id": "2", "title": "021 Formatura"},
                        {"id": "3", "title": "Bravo"},
                        {"id": "4", "title": "Menu anterior"}
                      ]
                    }
                  ]
                },
                "footer": {
                  "text": "Clique no botão abaixo para selecionar uma opção"
                }
              }
            },
          ),
          DSTextMessageBubble(
            text: _longText,
            align: DSAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: DSColors.neutralLightBox,
              ),
              child: DSDashedBorder(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  height: 312,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          DSTextMessageBubble(
            align: DSAlign.left,
            text: 'Testando ',
            selectContent: const {
              "text": "Você gostaria de um atendimento humano?",
              "options": [
                {
                  "text": "Sim",
                  "type": "text/plain",
                  "value": "payload do sim"
                },
                {"text": "Não", "order": 1},
                {"text": "Talvez"},
                {
                  "text": "Outro",
                  "type": "application/json",
                  "value": {"chave": "valor"}
                }
              ]
            },
            showSelect: true,
          ),
          DSTextMessageBubble(
            text:
                'Exemplo de preview completo e borda "reta": https://www.take.net/ paollalira@outlook.com',
            align: DSAlign.right,
            borderRadius: const [
              DSBorderRadius.bottomLeft,
              DSBorderRadius.topLeft,
            ],
          ),
          DSTextMessageBubble(
            text: 'Exemplo de preview completo: https://www.take.net/',
            align: DSAlign.left,
          ),
          DSTextMessageBubble(
            text: 'Exemplo de preview simples: https://www.google.com.br/',
            align: DSAlign.right,
          ),
          DSTextMessageBubble(
            text: 'Exemplo de URL inválido: https://www.google.c.br/',
            align: DSAlign.left,
          ),
          DSTextMessageBubble(
            text:
                'Exemplo de preview sem info: https://www.ledr.com/colours/cyan.htm',
            align: DSAlign.right,
          ),
          DSTextMessageBubble(
            text:
                'Lista de URLs:\n- https://www.take.net/\n- https://www.google.com.br/\n- https://pub.dev/packages/linkify',
            align: DSAlign.left,
          ),
          DSTextMessageBubble(
            text:
                'Texto antes do link https://pub.dev/packages/linkify e texto depois do link!',
            align: DSAlign.right,
          ),
          DSFileMessageBubble(
            text:
                'Texto de exemplo para exemplificar uma descrição enviado junto com um File.',
            align: DSAlign.left,
            filename: 'teste.pdf',
            size: 0,
            url:
                'https://download.brother.com/welcome/doc100107/cv_mfc4620dw_epr_busr_leu359065.pdf',
          ),
          DSFileMessageBubble(
              align: DSAlign.right,
              filename: 'master.zip',
              size: 500,
              url:
                  'https://github.com/takenet/blip-cards-vue-components/archive/refs/heads/master.zip'),
          DSUnsupportedContentMessageBubble(
            align: DSAlign.left,
          ),
          DSUnsupportedContentMessageBubble(
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
            url: '',
            title: 'Hello',
            text: 'My picture',
            appBarText: 'Unknown User',
          ),
          DSImageMessageBubble(
            align: DSAlign.right,
            url: _sampleImages['extraLarge']!,
            title: '2000x1330.png',
            text: _longText,
            appBarText: 'Unknown User',
          ),
          DSImageMessageBubble(
            align: DSAlign.right,
            url: _sampleImages['large']!,
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
            uri: Uri.parse(_sampleAudio),
            uniqueId: 'audio1',
          ),
          DSAudioMessageBubble(
            align: DSAlign.right,
            uri: Uri.parse(_sampleAudio),
            uniqueId: 'audio2',
          ),
          DSVideoMessageBubble(
            align: DSAlign.right,
            url: _srcsVideo[0],
            text: '.mov',
            appBarText: 'Unknown User',
            mediaSize: 10000,
          ),
          DSVideoMessageBubble(
            align: DSAlign.left,
            url: _srcsVideo[1],
            text: '.avi!',
            appBarText: 'Unknown User',
            mediaSize: 10000,
          ),
          DSVideoMessageBubble(
            align: DSAlign.right,
            url: _srcsVideo[2],
            text: '.mpeg',
            appBarText: 'Unknown User',
            mediaSize: 10000,
          ),
          DSVideoMessageBubble(
            align: DSAlign.right,
            url: _srcsVideo[3],
            text: '.mpg',
            appBarText: 'Unknown User',
            mediaSize: 10000,
          ),
          DSContactMessageBubble(
            address: null,
            align: DSAlign.right,
            email: 'emial@email.com',
            name: 'Name Name name',
            phone: '99 9999-9999',
          ),
          DSSurveyMessageBubble(
            align: DSAlign.center,
          ),
          DSLocationMessageBubble(
            align: DSAlign.left,
            latitude: '47.5951518',
            longitude: '122.3316393',
          ),
          DSRequestLocationBubble(
            label: 'Send location',
            value: 'Send location title',
            align: DSAlign.right,
            showRequestLocationButton: true,
          ),
        ],
      ),
    );
  }
}
