import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DSAudioSeekBarWidget extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final VoidCallback? onChangeEnd;
  final VoidCallback? onChangeStart;
  final DSAlign align;

  const DSAudioSeekBarWidget({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    this.onChangeStart,
    required this.align,
  }) : super(key: key);

  @override
  DSAudioSeekBarWidgetState createState() => DSAudioSeekBarWidgetState();
}

class DSAudioSeekBarWidgetState extends State<DSAudioSeekBarWidget> {
  late SliderThemeData sliderThemeData = SliderTheme.of(context).copyWith(
    trackHeight: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _bufferSlider(),
        _slider(),
        _audioLabel(widget.duration, DSAlign.right),
        _audioLabel(widget.position, DSAlign.left),
      ],
    );
  }

  Widget _bufferSlider() {
    return Positioned.fill(
      bottom: 12.0,
      child: SliderTheme(
        data: sliderThemeData.copyWith(
          thumbShape: HiddenThumbComponentShape(),
          activeTrackColor: Colors.red, //TODO: Buffer's color
          inactiveTrackColor: widget.align == DSAlign.right
              ? DSColors.neutralDarkRooftop
              : DSColors.neutralLightBox,
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

  Widget _slider() {
    return Positioned.fill(
      bottom: 12.0,
      child: SliderTheme(
        data: sliderThemeData.copyWith(
          inactiveTrackColor: Colors.transparent,
          thumbColor: widget.align == DSAlign.right
              ? DSColors.neutralLightSnow
              : DSColors.neutralDarkRooftop,
          activeTrackColor: widget.align == DSAlign.right
              ? DSColors.primaryLight
              : DSColors.primaryNight,
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
      ),
    );
  }

  Widget _audioLabel(final Duration value, final DSAlign align) {
    return Positioned(
      right: align == DSAlign.right ? 22.0 : null,
      left: align == DSAlign.left ? 22.0 : null,
      bottom: 10.0,
      child: Text(
        RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                .firstMatch("$value")
                ?.group(1) ??
            "$value",
        style: TextStyle(
          color: widget.align == DSAlign.right
              ? DSColors.neutralLightSnow
              : DSColors.neutralDarkCity,
        ),
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
