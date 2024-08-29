import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/extensions/ds_localization.extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'ds_chat_test.util.dart';

void main() {
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
            'delivery.send-fail'.translate(),
            findRichText: true,
          );

          expect(findMessage, findsOneWidget);
        },
      );
    },
  );
}
