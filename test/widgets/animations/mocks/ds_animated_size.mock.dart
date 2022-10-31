import 'package:blip_ds/src/themes/colors/ds_colors.theme.dart';
import 'package:blip_ds/src/widgets/animations/ds_animated_size.widget.dart';
import 'package:flutter/material.dart';

class MockDSAnimatedSize extends StatefulWidget {
  final double initWidth;
  final double initHeight;

  const MockDSAnimatedSize({
    super.key,
    required this.initWidth,
    required this.initHeight,
  });

  @override
  State<MockDSAnimatedSize> createState() => _MockDSAnimatedSizeState();
}

class _MockDSAnimatedSizeState extends State<MockDSAnimatedSize> {
  double? currentWidth;
  double? currentHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentWidth = widget.initWidth * 30;
          currentHeight = widget.initHeight * 30;
        });
      },
      child: DSAnimatedSize(
        child: Container(
          width: currentWidth ?? widget.initWidth,
          height: currentHeight ?? widget.initHeight,
          color: DSColors.extendRedsDragon,
        ),
      ),
    );
  }
}
