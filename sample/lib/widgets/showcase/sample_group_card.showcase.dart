import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SampleGroupCardShowcase extends StatelessWidget {
  const SampleGroupCardShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final documents = RxList<DSMessageItemModel>();

    documents.addAll([
      DSMessageItemModel(
          content: {
            "previewType": "image/png",
            "previewUri": "https://picsum.photos/250?image=9",
            "size": 500,
            "text": "legenda",
            "title": "Double check.png",
            "type": "image/png",
            "uri": "https://picsum.photos/250?image=9",
          },
          date: '2022-08-22T16:21:01.938Z',
          displayDate: '8 de Ago de 2022 16:21',
          align: DSAlign.right,
          type: 'application/vnd.lime.media-link+json',
          status: DSDeliveryReportStatus.consumed,
          customerName: 'André Rossi'),
      DSMessageItemModel(
        content: {
          'previewType': "application/pdf",
          'previewUri':
              "https://download.brother.com/welcome/doc100107/cv_mfc4620dw_epr_busr_leu359065.pdf",
          'size': 1203179,
          'text': "legenda do pdf",
          'title': "teste.pdf",
          'type': "application/pdf",
          'uri':
              "https://download.brother.com/welcome/doc100107/cv_mfc4620dw_epr_busr_leu359065.pdf",
        },
        date: '2022-08-22T16:20:00.938Z',
        displayDate: '8 de Ago de 2022 16:20',
        align: DSAlign.right,
        type: "application/vnd.lime.media-link+json",
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: {
          "previewType": "audio/mpeg",
          "previewUri":
              "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
          "size": 61056,
          "text": "",
          "title": "1661185184764.mp3",
          "type": "audio/mpeg",
          "uri":
              "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
        },
        date: '2022-08-22T16:19:58.938Z',
        displayDate: '8 de Ago de 2022 16:19',
        align: DSAlign.right,
        type: 'application/vnd.lime.media-link+json',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'vou mandar audio',
        date: '2022-08-22T12:35:43.717Z',
        displayDate: '8 de Ago de 2022 12:35',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'pode me ajudar?',
        date: '2022-08-22T12:35:38.704Z',
        displayDate: '8 de Ago de 2022 12:35',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'estou com problema no login',
        date: '2022-08-22T12:34:20.577Z',
        displayDate: '8 de Ago de 2022 12:34',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'sim',
        date: '2022-08-22T12:34:19.554Z',
        displayDate: '8 de Ago de 2022 12:34',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'olá',
        date: '2022-08-22T12:34:12.788Z',
        displayDate: '8 de Ago de 2022 12:34',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'ta por ai?',
        date: '2022-08-22T12:33:18.899Z',
        displayDate: '8 de Ago de 2022 12:33',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'precisa de ajuda?',
        date: '2022-08-22T12:25:26.684Z',
        displayDate: '8 de Ago de 2022 12:25',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'tudo bem?',
        date: '2022-08-22T12:25:24.362Z',
        displayDate: '8 de Ago de 2022 12:25',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'oi',
        date: '2022-08-22T12:25:23.189Z',
        displayDate: '8 de Ago de 2022 12:25',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: '1',
        date: '2022-08-22T12:25:02.934Z',
        displayDate: '8 de Ago de 2022 12:25',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: '1 - falar com humano',
        date: '2022-08-22T12:25:01.050Z',
        displayDate: '8 de Ago de 2022 12:25',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'Olá! Tester 22-08-22 09:24:51!\nSeja bem-vindo(a)!',
        date: '2022-08-22T12:25:01.035Z',
        displayDate: '8 de Ago de 2022 12:25',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'ola',
        date: '22022-08-22T12:24:57.928Z',
        displayDate: '8 de Ago de 2022 12:24',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
    ]);

    documents.value = documents.reversed.toList();

    return Column(
      children: [
        DSBodyText(text: 'DS group card sample'),
        DSGroupCard(
          isComposing: false.obs,
          documents: documents,
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
        ),
      ],
    );
  }
}
