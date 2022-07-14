import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/theme/systems_colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DSAudioMessageBubble extends StatefulWidget {
  final String uri;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;

  const DSAudioMessageBubble(
      {Key? key,
      required this.uri,
      required this.align,
      required this.borderRadius})
      : super(key: key);

  @override
  State<DSAudioMessageBubble> createState() => _DSAudioMessageBubbleState();
}

class _DSAudioMessageBubbleState extends State<DSAudioMessageBubble>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();

  double _audioSpeed = 1.0;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  Future<void> _init() async {
    _player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.stop();
      }
    });

    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.uri)));
    } catch (e) {
      //TODO: Review error
      print("Error loading audio source: $e");
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      contentPadding: EdgeInsets.zero,
      borderRadius: widget.borderRadius,
      align: widget.align,
      child: SizedBox(
        height: 62.0,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Positioned(
                    left: 12.0,
                    top: 14.0,
                    child: SpinKitFadingCircle(
                      color: widget.align == DSAlign.left
                          ? SystemColors.neutralDarkRooftop
                          : SystemColors.neutralLightSnow,
                      size: 30.0,
                    ),
                  );
                } else if (playing != true) {
                  return IconButton(
                    splashRadius: 1,
                    icon: Image.asset(widget.align == DSAlign.left
                        ? 'play_neutral_dark_rooftop.png'
                        : 'play_neutral_light_snow.png'),
                    iconSize: 42.0,
                    onPressed: _player.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    splashRadius: 1,
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 9.0,
                          height: 26.0,
                          decoration: BoxDecoration(
                            color: widget.align == DSAlign.right
                                ? SystemColors.neutralLightSnow
                                : SystemColors.neutralDarkRooftop,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3.0)),
                          ),
                        ),
                        Container(
                          width: 9.0,
                          height: 26.0,
                          decoration: BoxDecoration(
                            color: widget.align == DSAlign.right
                                ? SystemColors.neutralLightSnow
                                : SystemColors.neutralDarkRooftop,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3.0)),
                          ),
                        )
                      ],
                    ),
                    iconSize: 42.0,
                    onPressed: _player.pause,
                  );
                } else {
                  return IconButton(
                    splashRadius: 1,
                    icon: const Icon(
                      Icons.replay,
                      color: SystemColors.neutralDarkRooftop,
                    ),
                    iconSize: 42.0,
                    onPressed: () => _player.seek(Duration.zero),
                  );
                }
              },
            ),
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                  ),
                  child: SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: _player.seek,
                    align: widget.align,
                  ),
                );
              },
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(color: SystemColors.neutralMediumSilver),
                ),
                child: GestureDetector(
                  onTap: () {
                    if (_audioSpeed == 1) {
                      _audioSpeed = 1.5;
                    } else if (_audioSpeed == 1.5) {
                      _audioSpeed = 2.0;
                    } else {
                      _audioSpeed = 1.0;
                    }

                    setState(() {
                      _player.setSpeed(_audioSpeed);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getAudioSpeedLabel(),
                          style: TextStyle(
                              color: widget.align == DSAlign.right
                                  ? SystemColors.neutralLightSnow
                                  : SystemColors.neutralDarkCity),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getAudioSpeedLabel() {
    if (_audioSpeed == 1) {
      return 'x1';
    } else if (_audioSpeed == 1.5) {
      return 'x1.5';
    } else {
      return 'x2';
    }
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;
  final DSAlign align;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    required this.align,
  }) : super(key: key);

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData = SliderTheme.of(context).copyWith(
    trackHeight: 2.0,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          bottom: 12.0,
          child: SliderTheme(
            data: _sliderThemeData.copyWith(
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
        ),
        Positioned.fill(
          bottom: 12.0,
          child: SliderTheme(
            data: _sliderThemeData.copyWith(
                inactiveTrackColor: Colors.transparent,
                thumbColor: widget.align == DSAlign.right
                    ? SystemColors.neutralLightSnow
                    : SystemColors.neutralDarkRooftop,
                activeTrackColor: widget.align == DSAlign.right
                    ? SystemColors.primaryLight
                    : SystemColors.primaryNight,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 7.0)),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(
                  _dragValue ?? widget.position.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        Positioned(
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
                      : SystemColors.neutralDarkCity)),
        ),
        Positioned(
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
                      : SystemColors.neutralDarkCity)),
        ),
      ],
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
