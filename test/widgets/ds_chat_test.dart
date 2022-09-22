import 'package:blip_ds/blip_ds.dart';
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

          final Finder findBubble = find.byType(DSMessageBubble);

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
        'Unsupported content should have custom alignment',
        (tester) async {
          const DSAlign leftAlign = DSAlign.left;
          const DSAlign rightAlign = DSAlign.right;
          const DSAlign centerAlign = DSAlign.center;

          final bubbles = Column(
            children: [
              _buildUnsupportedContent(
                align: leftAlign,
              ),
              _buildUnsupportedContent(
                align: rightAlign,
              ),
              _buildUnsupportedContent(
                align: centerAlign,
              ),
            ],
          );

          await tester.pumpWidget(
            _buildMaterialApp(bubbles),
          );

          final Finder findLeftBubble = find.byWidgetPredicate(
            (widget) => widget is DSMessageBubble && widget.align == leftAlign,
          );

          final Finder findRightBubble = find.byWidgetPredicate(
            (widget) => widget is DSMessageBubble && widget.align == rightAlign,
          );

          final Finder findCenterBubble = find.byWidgetPredicate(
            (widget) =>
                widget is DSMessageBubble && widget.align == centerAlign,
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
  DSAlign align = DSAlign.left,
  Widget? leftWidget,
  String? text,
  List<DSBorderRadius> borderRadius = const [DSBorderRadius.all],
}) {
  return DSUnsupportedContentMessageBubble(
    align: align,
    leftWidget: leftWidget,
    text: text,
    borderRadius: borderRadius,
  );
}
