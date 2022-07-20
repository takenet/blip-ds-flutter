import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/theme/systems_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AudioSeekBarWidget extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;
  final DSAlign align;

  const AudioSeekBarWidget({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    required this.align,
  }) : super(key: key);

  @override
  AudioSeekBarWidgetState createState() => AudioSeekBarWidgetState();
}

class AudioSeekBarWidgetState extends State<AudioSeekBarWidget> {
  late SliderThemeData sliderThemeData = SliderTheme.of(context).copyWith(
    trackHeight: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bufferSlider(),
        slider(),
        audioDuration(),
        audioPosition(),
      ],
    );
  }

  Widget bufferSlider() {
    return Positioned.fill(
      bottom: 12.0,
      child: SliderTheme(
        data: sliderThemeData.copyWith(
          thumbShape: HiddenThumbComponentShape(),
          activeTrackColor: Colors.red, //TODO: Buffer's color
          inactiveTrackColor: widget.align == DSAlign.right
              ? SystemColors.neutralDarkRooftop
              : SystemColors.neutralLightBox,
        ),
        child: ExcludeSemantics(
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (v) {},
          ),
        ),
      ),
    );
  }

  Widget slider() {
    return Positioned.fill(
      bottom: 12.0,
      child: SliderTheme(
        data: sliderThemeData.copyWith(
          inactiveTrackColor: Colors.transparent,
          thumbColor: widget.align == DSAlign.right
              ? SystemColors.neutralLightSnow
              : SystemColors.neutralDarkRooftop,
          activeTrackColor: widget.align == DSAlign.right
              ? SystemColors.primaryLight
              : SystemColors.primaryNight,
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: 7.0,
          ),
        ),
        child: Slider(
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: min(widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble()),
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd!(Duration(milliseconds: value.round()));
            }
          },
        ),
      ),
    );
  }

  Widget audioDuration() {
    return Positioned(
      right: 22.0,
      bottom: 10.0,
      child: Text(
        RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                .firstMatch("${widget.duration}")
                ?.group(1) ??
            '${widget.duration}',
        style: TextStyle(
            color: widget.align == DSAlign.right
                ? SystemColors.neutralLightSnow
                : SystemColors.neutralDarkCity),
      ),
    );
  }

  Widget audioPosition() {
    return Positioned(
      left: 22.0,
      bottom: 10.0,
      child: Text(
        RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                .firstMatch("${widget.position}")
                ?.group(1) ??
            '${widget.position}',
        style: TextStyle(
            color: widget.align == DSAlign.right
                ? SystemColors.neutralLightSnow
                : SystemColors.neutralDarkCity),
      ),
    );
  }
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}
