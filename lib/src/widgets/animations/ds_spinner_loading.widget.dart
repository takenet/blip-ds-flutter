import 'dart:math';
import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSSpinnerLoading extends StatefulWidget {
  const DSSpinnerLoading({
    Key? key,
    required this.color,
    this.lineWidth = 5.0,
    this.size = 30.0,
    this.duration = const Duration(milliseconds: 500),
    this.controller,
  }) : super(key: key);

  final Color color;
  final double size;
  final double lineWidth;
  final Duration duration;
  final AnimationController? controller;

  @override
  DSSpinnerLoadingState createState() => DSSpinnerLoadingState();
}

class DSSpinnerLoadingState extends State<DSSpinnerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() => setState(() {}))
      ..repeat();

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.fromSize(
          size: Size.square(widget.size),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                width: widget.lineWidth,
                color: DSColors.neutralMediumWave,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..rotateZ((_animation.value) * 6.0 * pi / 6.0),
          alignment: FractionalOffset.center,
          child: SizedBox.fromSize(
            size: Size.square(widget.size),
            child: CustomPaint(
              foregroundPainter: Paiter(
                paintWidth: widget.lineWidth,
                trackColor: widget.color,
                progressPercent: _animation.value,
                startAngle: pi * _animation.value,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Paiter extends CustomPainter {
  Paiter({
    required this.paintWidth,
    this.progressPercent,
    this.startAngle,
    required this.trackColor,
  }) : trackPaint = Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = paintWidth
          ..strokeCap = StrokeCap.round;

  final double paintWidth;
  final Paint trackPaint;
  final Color trackColor;
  final double? progressPercent;
  final double? startAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - paintWidth) / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle!,
      1,
      false,
      trackPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
