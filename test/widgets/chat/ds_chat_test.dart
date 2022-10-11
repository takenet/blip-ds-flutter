import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'ds_chat_test.util.dart';

void main() {
  setUpAll(
    () async => await loadAppFonts(),
  );

  group(
    'Delivery Report Icon',
    () {
      testGoldens(
        'Delivery report should match golden image',
        (tester) async {
          final builder = DSChatTestUtils.createDeliveryReportIconScenarios();

          await tester.pumpWidgetBuilder(builder.build());

          await screenMatchesGolden(
            tester,
            DSChatTestUtils.deliveryReportIconGoldenPath,
            autoHeight: true,
          );
        },
      );

      testWidgets(
        'Delivery report failed message should be displayed when status is failed or unknown',
        (tester) async {
          final messages = DSChatTestUtils.buildDeliveryReportIcon(
            deliveryStatus: DSDeliveryReportStatus.failed,
          );

          await tester.pumpWidgetBuilder(messages);

          final Finder findMessage = find.text(
            'Falha ao enviar mensagem.', // TODO: translate
            findRichText: true,
          );

          expect(findMessage, findsOneWidget);
        },
      );
    },
  );
}
