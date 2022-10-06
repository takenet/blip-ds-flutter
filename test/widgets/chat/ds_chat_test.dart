import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_file_message_bubble.controller.dart';
import 'package:blip_ds/src/widgets/chat/ds_delivery_report_icon.widget.dart';
import 'package:blip_ds/src/widgets/texts/ds_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Delivery Report Icon',
    skip: true, // TODO: golden test
    () {
      testWidgets(
        'Delivery report accepted icon should match golden image when status is accepted',
        (tester) async {
          final DSDeliveryReportIcon icon = _buildDeliveryReportIcon(
            deliveryStatus: DSDeliveryReportStatus.accepted,
          );

          await tester.pumpWidget(icon);

          // TODO: golden test
        },
      );

      testWidgets(
        'Delivery report received icon should match golden image when status is received',
        (tester) async {
          final DSDeliveryReportIcon icon = _buildDeliveryReportIcon(
            deliveryStatus: DSDeliveryReportStatus.received,
          );

          await tester.pumpWidget(icon);

          // TODO: golden test
        },
      );

      testWidgets(
        'Delivery report consumed icon should match golden image',
        (tester) async {
          final DSDeliveryReportIcon icon = _buildDeliveryReportIcon(
            deliveryStatus: DSDeliveryReportStatus.consumed,
          );

          await tester.pumpWidget(icon);

          // TODO: golden test
        },
      );

      testWidgets(
        'Delivery report failed message should be displayed when status is failed or unknown',
        (tester) async {
          final messages = Column(
            children: [
              _buildDeliveryReportIcon(
                deliveryStatus: DSDeliveryReportStatus.failed,
              ),
              _buildDeliveryReportIcon(
                deliveryStatus: DSDeliveryReportStatus.unknown,
              ),
            ],
          );

          await tester.pumpWidget(
            _buildMaterialApp(messages),
          );

          final Finder findMessage = find.text(
            'Falha ao enviar mensagem.', // TODO: translate
            findRichText: true,
          );

          final Finder findColor = find.byWidgetPredicate(
            (widget) =>
                widget is DSText && widget.color == DSColors.extendRedsDragon,
          );

          expect(findMessage, findsNWidgets(2));
          expect(findColor, findsNWidgets(2));
        },
      );
    },
  );

  group(
    'Unsupported Content Bubble',
    skip: true, // TODO: golden test
    () {
      testWidgets(
        'Unsupported content should use DSMessageBubble in its structure',
        (tester) async {
          final DSUnsupportedContentMessageBubble bubble =
              _buildUnsupportedContent();

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findBubble = find.descendant(
            of: find.byWidget(bubble),
            matching: find.byType(DSMessageBubble),
          );

          expect(findBubble, findsOneWidget);
        },
      );

      testWidgets(
        'Unsupported content should have default text',
        (tester) async {
          final DSUnsupportedContentMessageBubble bubble =
              _buildUnsupportedContent();

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findText = find.text(
            'Unsupported content',
            findRichText: true,
          );

          expect(findText, findsOneWidget);
        },
      );

      testWidgets(
        'Unsupported content should have custom text',
        (tester) async {
          const String text = 'Custom text 123 !@#';

          final DSUnsupportedContentMessageBubble bubble =
              _buildUnsupportedContent(text: text);

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findText = find.text(
            text,
            findRichText: true,
          );

          expect(findText, findsOneWidget);
        },
      );

      testWidgets(
        'Unsupported content should have default icon',
        (tester) async {
          final DSUnsupportedContentMessageBubble bubble =
              _buildUnsupportedContent();

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'Unsupported content should have custom icon',
        (tester) async {
          const IconData icon = Icons.add;

          final DSUnsupportedContentMessageBubble bubble =
              _buildUnsupportedContent(
            leftWidget: const Icon(icon),
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findIcon = find.byIcon(icon);

          expect(findIcon, findsOneWidget);
        },
      );

      testWidgets(
        'Unsupported content should have a Neutral Light Snow foreground color',
        (tester) async {
          // TODO
        },
      );

      testWidgets(
        'Unsupported content should have a Neutral Dark City foreground color',
        (tester) async {
          // TODO
        },
      );

      testWidgets(
        'Unsupported content should have custom alignment',
        (tester) async {
          const DSAlign leftAlign = DSAlign.left;
          const DSAlign rightAlign = DSAlign.right;
          const DSAlign centerAlign = DSAlign.center;

          const Key keyLeftAlign = Key('left-align');
          const Key keyRightAlign = Key('right-align');
          const Key keyCenterAlign = Key('center-align');

          final bubbles = Column(
            children: [
              _buildUnsupportedContent(
                key: keyLeftAlign,
                align: leftAlign,
              ),
              _buildUnsupportedContent(
                key: keyRightAlign,
                align: rightAlign,
              ),
              _buildUnsupportedContent(
                key: keyCenterAlign,
                align: centerAlign,
              ),
            ],
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubbles),
          );

          final Finder findLeftBubble = find.byWidgetPredicate(
            (widget) =>
                widget is DSMessageBubble &&
                widget.key == keyLeftAlign &&
                widget.align == leftAlign,
          );

          final Finder findRightBubble = find.byWidgetPredicate(
            (widget) =>
                widget is DSMessageBubble &&
                widget.key == keyRightAlign &&
                widget.align == rightAlign,
          );

          final Finder findCenterBubble = find.byWidgetPredicate(
            (widget) =>
                widget is DSMessageBubble &&
                widget.key == keyCenterAlign &&
                widget.align == centerAlign,
          );

          expect(findLeftBubble, findsOneWidget);
          expect(findRightBubble, findsOneWidget);
          expect(findCenterBubble, findsOneWidget);
        },
      );

      testWidgets(
        'Unsupported content should have custom border radius',
        (tester) async {
          const List<DSBorderRadius> borderRadius = [
            DSBorderRadius.topLeft,
            DSBorderRadius.bottomRight,
          ];

          final DSUnsupportedContentMessageBubble bubble =
              _buildUnsupportedContent(
            borderRadius: borderRadius,
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findBubble = find.byWidgetPredicate(
            (widget) =>
                widget is DSMessageBubble &&
                widget.borderRadius == borderRadius,
          );

          expect(findBubble, findsOneWidget);
        },
      );
    },
  );

  group(
    'File Bubble',
    () {
      testWidgets(
        'File bubble should have DSMessageBubble in its structure',
        (tester) async {
          final DSFileMessageBubble bubble = _buildFileBubble();

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findBubble = find.descendant(
            of: find.byWidget(bubble),
            matching: find.byType(DSMessageBubble),
          );

          expect(findBubble, findsOneWidget);
        },
      );

      testWidgets(
        'File bubble should have default file icon',
        skip: true,
        (tester) async {
          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: 'test_file',
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'File bubble should have CSV file icon',
        skip: true,
        (tester) async {
          const String extension = '.csv';

          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: 'test_file$extension',
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'File bubble should have DOC file icon',
        skip: true,
        (tester) async {
          const String extension = '.doc';

          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: 'test_file$extension',
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'File bubble should have PDF file icon',
        skip: true,
        (tester) async {
          const String extension = '.pdf';

          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: 'test_file$extension',
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'File bubble should have PPT file icon',
        skip: true,
        (tester) async {
          const String extension = '.ppt';

          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: 'test_file$extension',
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'File bubble should have TXT file icon',
        skip: true,
        (tester) async {
          const String extension = '.txt';

          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: 'test_file$extension',
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'File bubble should have XLS file icon',
        skip: true,
        (tester) async {
          const String extension = '.xls';

          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: 'test_file$extension',
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'File bubble should have ZIP file icon',
        skip: true,
        (tester) async {
          const String extension = '.zip';

          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: 'test_file$extension',
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test
        },
      );

      testWidgets(
        'File bubble should have file name',
        (tester) async {
          const String filename = 'test_123.pdf';

          final DSFileMessageBubble bubble = _buildFileBubble(
            filename: filename,
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findText = find.text(
            filename,
            findRichText: true,
          );

          expect(findText, findsOneWidget);
        },
      );

      testWidgets(
        'File bubble should have file size',
        (tester) async {
          const int size = 50;

          final controller = DSFileMessageBubbleController();

          final DSFileMessageBubble bubble = _buildFileBubble(
            size: size,
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findText = find.text(
            controller.getFileSize(size),
            findRichText: true,
          );

          expect(findText, findsOneWidget);
        },
      );

      testWidgets(
        'File bubble should have a Neutral Light Snow foreground color',
        (tester) async {
          final DSFileMessageBubble bubble = _buildFileBubble(
            align: DSAlign.right,
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findColor = find.descendant(
            of: find.byWidget(bubble),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is DSText && widget.color == DSColors.neutralLightSnow,
            ),
          );

          expect(findColor, findsWidgets);
        },
      );

      testWidgets(
        'File bubble should have a Neutral Dark City foreground color',
        (tester) async {
          final DSFileMessageBubble bubble = _buildFileBubble(
            align: DSAlign.left,
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findColor = find.descendant(
            of: find.byWidget(bubble),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is DSText && widget.color == DSColors.neutralDarkCity,
            ),
          );

          expect(findColor, findsWidgets);
        },
      );

      testWidgets(
        'File bubble should have a Neutral Light Snow background colored container around the file icon',
        skip: true,
        (tester) async {
          final DSFileMessageBubble bubble = _buildFileBubble();

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          // TODO: golden test

          // final Finder findColor = find.descendant(
          //   of: find.byWidget(bubble),
          //   matching: find.descendant(of: find.byWidgetPredicate(
          //     (widget) =>
          //         widget is Container &&
          //         widget.color == DSColors.neutralLightSnow,
          //   ), matching: matching,)
          // );

          // expect(findColor, findsOneWidget);
        },
      );

      testWidgets(
        'File bubble should have custom alignment',
        (tester) async {
          const DSAlign leftAlign = DSAlign.left;
          const DSAlign rightAlign = DSAlign.right;
          const DSAlign centerAlign = DSAlign.center;

          const Key keyLeftAlign = Key('left-align');
          const Key keyRightAlign = Key('right-align');
          const Key keyCenterAlign = Key('center-align');

          final bubbles = Column(
            children: [
              _buildFileBubble(
                key: keyLeftAlign,
                align: leftAlign,
              ),
              _buildFileBubble(
                key: keyRightAlign,
                align: rightAlign,
              ),
              _buildFileBubble(
                key: keyCenterAlign,
                align: centerAlign,
              ),
            ],
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubbles),
          );

          final Finder findLeftBubble = find.descendant(
            of: find.byKey(keyLeftAlign),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is DSMessageBubble && widget.align == leftAlign,
            ),
          );

          final Finder findRightBubble = find.descendant(
            of: find.byKey(keyRightAlign),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is DSMessageBubble && widget.align == rightAlign,
            ),
          );

          final Finder findCenterBubble = find.descendant(
            of: find.byKey(keyCenterAlign),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is DSMessageBubble && widget.align == centerAlign,
            ),
          );

          expect(findLeftBubble, findsOneWidget);
          expect(findRightBubble, findsOneWidget);
          expect(findCenterBubble, findsOneWidget);
        },
      );

      testWidgets(
        'File bubble should have custom border radius',
        (tester) async {
          const List<DSBorderRadius> borderRadius = [
            DSBorderRadius.topLeft,
            DSBorderRadius.bottomRight,
          ];

          final DSFileMessageBubble bubble = _buildFileBubble(
            borderRadius: borderRadius,
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubble),
          );

          final Finder findBubble = find.byWidgetPredicate(
            (widget) =>
                widget is DSMessageBubble &&
                widget.borderRadius == borderRadius,
          );

          expect(findBubble, findsOneWidget);
        },
      );
    },
  );
}

MaterialApp _buildMaterialApp(Widget child) {
  return MaterialApp(
    home: child,
  );
}

DSDeliveryReportIcon _buildDeliveryReportIcon({
  Key? key,
  DSDeliveryReportStatus deliveryStatus = DSDeliveryReportStatus.accepted,
}) {
  return DSDeliveryReportIcon(
    key: key,
    deliveryStatus: deliveryStatus,
  );
}

DSUnsupportedContentMessageBubble _buildUnsupportedContent({
  Key? key,
  DSAlign align = DSAlign.left,
  Widget? leftWidget,
  String? text,
  List<DSBorderRadius> borderRadius = const [DSBorderRadius.all],
}) {
  return DSUnsupportedContentMessageBubble(
    key: key,
    align: align,
    leftWidget: leftWidget,
    text: text,
    borderRadius: borderRadius,
  );
}

DSFileMessageBubble _buildFileBubble({
  Key? key,
  DSAlign align = DSAlign.left,
  String url = 'https://shorturl.at/fgvY2',
  int size = 500,
  String filename = 'master.zip',
  List<DSBorderRadius> borderRadius = const [DSBorderRadius.all],
}) {
  return DSFileMessageBubble(
    key: key,
    align: align,
    url: url,
    size: size,
    filename: filename,
    borderRadius: borderRadius,
  );
}
