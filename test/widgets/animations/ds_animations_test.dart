import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Animated Size',
    () {
      testWidgets(
        'Animation should render the given child with the expected size',
        (tester) async {
          const double width = 10.0;
          const double height = 10.0;

          await tester.pumpWidget(
            _buildAnimatedSize(
              width: width,
              height: height,
            ),
          );

          expect(find.byType(DSAnimatedSize), findsOneWidget);

          final initBox = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(initBox.width, width);
          expect(initBox.height, height);
        },
      );
    },
  );

  group(
    'Ring Loading',
    () {
      testWidgets(
        'Ring loading should have the given color',
        (tester) async {
          const Color redColor = DSColors.extendRedsLipstick;

          final DSRingLoading loading = _buildRingLoading(
            color: redColor,
          );

          await tester.pumpWidget(loading);

          final Finder findLoading = find.byWidgetPredicate(
            (widget) => widget is DSRingLoading && widget.color == redColor,
          );

          expect(findLoading, findsOneWidget);
        },
      );

      testWidgets(
        'Ring loading should have the given size',
        (tester) async {
          const double size = 10.0;

          final DSRingLoading loading = _buildRingLoading(
            size: size,
          );

          await tester.pumpWidget(loading);

          final Finder findLoading = find.byWidgetPredicate(
            (widget) => widget is DSRingLoading && widget.size == size,
          );

          expect(findLoading, findsOneWidget);
        },
      );

      testWidgets(
        'Ring loading should have the given line width',
        (tester) async {
          const double lineWidth = 5.0;

          final DSRingLoading loading = _buildRingLoading(
            lineWidth: lineWidth,
          );

          await tester.pumpWidget(loading);

          final Finder findLoading = find.byWidgetPredicate(
            (widget) =>
                widget is DSRingLoading && widget.lineWidth == lineWidth,
          );

          expect(findLoading, findsOneWidget);
        },
      );
    },
  );

  group(
    'Fading Circle Loading',
    () {
      testWidgets(
        'Fading circle loading should have the given color',
        (tester) async {
          const Color greenColor = DSColors.primaryGreensTrue;

          final DSFadingCircleLoading loading = _buildFadingCircleLoading(
            color: greenColor,
          );

          await tester.pumpWidget(
            _buildMaterialApp(loading),
          );

          final Finder findLoading = find.byWidgetPredicate(
            (widget) =>
                widget is DSFadingCircleLoading && widget.color == greenColor,
          );

          expect(findLoading, findsOneWidget);
        },
      );

      testWidgets(
        'Fading circle loading should have the given size',
        (tester) async {
          const double size = 10.0;

          final DSFadingCircleLoading loading = _buildFadingCircleLoading(
            size: size,
          );

          await tester.pumpWidget(
            _buildMaterialApp(loading),
          );

          final Finder findLoading = find.byWidgetPredicate(
            (widget) => widget is DSFadingCircleLoading && widget.size == size,
          );

          expect(findLoading, findsOneWidget);
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

DSAnimatedSize _buildAnimatedSize({
  double? width,
  double? height,
}) {
  return DSAnimatedSize(
    child: SizedBox(
      width: width,
      height: height,
    ),
  );
}

DSRingLoading _buildRingLoading({
  Color color = DSColors.primaryNight,
  double size = 24.0,
  double lineWidth = 2.0,
}) {
  return DSRingLoading(
    color: color,
    size: size,
    lineWidth: lineWidth,
  );
}

DSFadingCircleLoading _buildFadingCircleLoading({
  Color color = DSColors.primaryNight,
  double size = 24.0,
}) {
  return DSFadingCircleLoading(
    color: color,
    size: size,
  );
}
