import 'dart:math';

import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class DSAudioSeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final Color labelColor;
  final Color bufferActiveTrackColor;
  final Color bufferInactiveTrackColor;
  final Color sliderActiveTrackColor;
  final Color sliderThumbColor;
  final ValueChanged<Duration>? onChanged;
  final VoidCallback? onChangeEnd;
  final VoidCallback? onChangeStart;

  const DSAudioSeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.labelColor,
    required this.bufferActiveTrackColor,
    required this.bufferInactiveTrackColor,
    required this.sliderActiveTrackColor,
    required this.sliderThumbColor,
    this.onChanged,
    this.onChangeEnd,
    this.onChangeStart,
  });

  @override
  DSAudioSeekBarState createState() => DSAudioSeekBarState();
}

class DSAudioSeekBarState extends State<DSAudioSeekBar> {
  late SliderThemeData sliderThemeData = SliderTheme.of(context).copyWith(
    trackHeight: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _bufferSlider(),
        _slider(),
        Positioned(
          right: 23.0,
          bottom: 0.0,
          child: _audioLabel(widget.duration),
        ),
        Positioned(
          left: 23.0,
          bottom: 0.0,
          child: _audioLabel(widget.position),
        ),
      ],
    );
  }

  Widget _bufferSlider() => SliderTheme(
        data: sliderThemeData.copyWith(
          thumbShape: HiddenThumbComponentShape(),
          activeTrackColor: widget.bufferActiveTrackColor,
          inactiveTrackColor: widget.bufferInactiveTrackColor,
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
      );

  Widget _slider() => SliderTheme(
        data: sliderThemeData.copyWith(
          inactiveTrackColor: Colors.transparent,
          thumbColor: widget.sliderThumbColor,
          activeTrackColor: widget.sliderActiveTrackColor,
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
              widget.onChangeEnd!();
            }
          },
          onChangeStart: (value) {
            if (widget.onChangeStart != null) {
              widget.onChangeStart!();
            }
          },
        ),
      );

  Widget _audioLabel(final Duration value) => DSCaptionText(
        RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                .firstMatch("$value")
                ?.group(1) ??
            "$value",
        color: widget.labelColor,
      );
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
