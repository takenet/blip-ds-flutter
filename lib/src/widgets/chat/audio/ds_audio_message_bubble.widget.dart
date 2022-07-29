import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/loading/ds_fading_circle_loading.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_pause_button.widget.dart';
import 'package:blip_ds/src/widgets/buttons/ds_play_button.widget.dart';
import 'package:blip_ds/src/widgets/chat/audio/ds_audio_seek_bar.widget.dart';
import 'package:blip_ds/src/controllers/chat/ds_audio_message_bubble.controller.dart';
import 'package:blip_ds/src/widgets/chat/audio/ds_audio_speed_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DSAudioMessageBubble extends StatefulWidget {
  final String uri;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;

  const DSAudioMessageBubble({
    Key? key,
    required this.uri,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
  }) : super(key: key);

  @override
  State<DSAudioMessageBubble> createState() => _DSAudioMessageBubbleState();
}

class _DSAudioMessageBubbleState extends State<DSAudioMessageBubble>
    with WidgetsBindingObserver {
  final _controller = DSAudioMessageBubbleController();

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    _controller.player.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller.player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      contentPadding: EdgeInsets.zero,
      borderRadius: widget.borderRadius,
      align: widget.align,
      child: SizedBox(
        height: 62.0,
        child: Stack(
          children: [
            _controlButtons(),
            _seekBar(),
            Obx(
              () => DSAudioSpeedButton(
                text:
                    "x${_controller.audioSpeed.value.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '')}",
                onTap: _controller.setAudioSpeed,
                borderColor: widget.align == DSAlign.right
                    ? DSColors.disabledText
                    : DSColors.neutralMediumSilver,
                color: widget.align == DSAlign.right
                    ? DSColors.neutralLightSnow
                    : DSColors.neutralDarkCity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _init() async {
    _controller.player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        _controller.player.seek(Duration.zero);
        _controller.player.stop();
      }
    });

    await _controller.player
        .setAudioSource(AudioSource.uri(Uri.parse(widget.uri)));
  }

  Widget _controlButtons() {
    return StreamBuilder<PlayerState>(
      stream: _controller.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if ([ProcessingState.loading, ProcessingState.buffering]
            .contains(processingState)) {
          return Positioned(
            left: 12.0,
            top: 14.0,
            child: DSFadingCircleLoading(
              color: widget.align == DSAlign.left
                  ? DSColors.neutralDarkRooftop
                  : DSColors.neutralLightSnow,
            ),
          );
        } else if (playing != true) {
          return DSPlayButton(
            onPressed: _controller.player.play,
            icon: widget.align == DSAlign.left
                ? DSPlayButtonIconColor.neutralLightSnow
                : DSPlayButtonIconColor.neutralDarkRooftop,
          );
        } else if (processingState != ProcessingState.completed) {
          return DSPauseButton(
            onPressed: _controller.player.pause,
            color: widget.align == DSAlign.right
                ? DSColors.neutralLightSnow
                : DSColors.neutralDarkRooftop,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _seekBar() {
    return StreamBuilder<PositionData>(
      stream: _controller.positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
          ),
          child: DSAudioSeekBar(
            duration: positionData?.duration ?? Duration.zero,
            position: positionData?.position ?? Duration.zero,
            bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
            onChangeEnd: _controller.player.play,
            onChanged: _controller.player.seek,
            onChangeStart: _controller.player.pause,
            align: widget.align,
          ),
        );
      },
    );
  }
}
