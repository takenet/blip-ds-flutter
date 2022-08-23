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
        date: '2022-08-22T16:19:50.938Z',
        align: DSAlign.right,
        type: 'application/vnd.lime.media-link+json',
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
        date: '2022-08-22T16:19:45.938Z',
        align: DSAlign.right,
        type: 'application/vnd.lime.media-link+json',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'olaa',
        date: '2022-08-22T12:35:43.717Z',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'ola',
        date: '2022-08-22T12:35:38.704Z',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: '1',
        date: '2022-08-22T12:34:20.577Z',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'agrup',
        date: '2022-08-22T12:34:19.554Z',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'teste',
        date: '2022-08-22T12:34:12.788Z',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'teste 2',
        date: '2022-08-22T12:33:18.899Z',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'agrupamento 1',
        date: '2022-08-22T12:25:26.684Z',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'teste',
        date: '2022-08-22T12:25:24.362Z',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'oi',
        date: '2022-08-22T12:25:23.189Z',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: '1',
        date: '2022-08-22T12:25:02.934Z',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: '1 - falar com humano',
        date: '2022-08-22T12:25:01.050Z',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'Olá! Tester 22-08-22 09:24:51!\nSeja bem-vindo(a)!',
        date: '2022-08-22T12:25:01.035Z',
        align: DSAlign.right,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
      DSMessageItemModel(
        content: 'ola',
        date: '22022-08-22T12:24:57.928Z',
        align: DSAlign.left,
        type: 'text/plain',
        status: DSDeliveryReportStatus.consumed,
      ),
    ]);

    //TODO: remove
    documents.value = documents.reversed.toList();

    return Column(
      children: [
        DSPrimaryButton(
            label: 'add message',
            onPressed: () {
              documents.add(
                DSMessageItemModel(
                    date: '2022-08-22T16:20:50.938Z',
                    align: DSAlign.right,
                    type: 'text/plain',
                    status: DSDeliveryReportStatus.consumed,
                    content: 'New message'),
              );
            }),
        DSGroupCard(
          documents: documents,
          compareMessages: (msg1, msg2) {
            final firstDate = DateTime.parse(msg1.date.toString());
            final secondDate = DateTime.parse(msg2.date);

            return (firstDate.difference(secondDate).inSeconds <= 60 &&
                    msg1.status == msg2.status &&
                    msg1.align == msg2.align)
                ? true
                : false;
          },
        ),
      ],
    );
  }
}
