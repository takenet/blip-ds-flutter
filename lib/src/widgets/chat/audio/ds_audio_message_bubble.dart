import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/widgets/chat/audio/audio_seek_bar.widget.dart';
import 'package:blip_ds/src/controllers/chat/ds_audio_message_bubble.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  final controller = DSAudioMessageBubbleController();

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    controller.player.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      controller.player.stop();
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
            controlButtons(),
            seekBar(),
            audioSpeed(),
          ],
        ),
      ),
    );
  }

  Future<void> init() async {
    controller.player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        controller.player.seek(Duration.zero);
        controller.player.stop();
      }
    });

    await controller.player
        .setAudioSource(AudioSource.uri(Uri.parse(widget.uri)));
  }

  Widget controlButtons() {
    Widget playButton() {
      return IconButton(
        splashRadius: 1,
        icon: Image.asset(widget.align == DSAlign.left
            ? 'play_neutral_dark_rooftop.png'
            : 'play_neutral_light_snow.png'),
        iconSize: 42.0,
        onPressed: controller.player.play,
      );
    }

    Widget loading() {
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
    }

    Widget pauseButton() {
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
                borderRadius: const BorderRadius.all(Radius.circular(3.0)),
              ),
            ),
            Container(
              width: 9.0,
              height: 26.0,
              decoration: BoxDecoration(
                color: widget.align == DSAlign.right
                    ? SystemColors.neutralLightSnow
                    : SystemColors.neutralDarkRooftop,
                borderRadius: const BorderRadius.all(Radius.circular(3.0)),
              ),
            )
          ],
        ),
        iconSize: 42.0,
        onPressed: controller.player.pause,
      );
    }

    Widget replayButton() {
      return IconButton(
        splashRadius: 1,
        icon: const Icon(
          Icons.replay,
          color: SystemColors.neutralDarkRooftop,
        ),
        iconSize: 42.0,
        onPressed: () => controller.player.seek(Duration.zero),
      );
    }

    return StreamBuilder<PlayerState>(
      stream: controller.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if ([ProcessingState.loading, ProcessingState.buffering]
            .contains(processingState)) {
          return loading();
        } else if (playing != true) {
          return playButton();
        } else if (processingState != ProcessingState.completed) {
          return pauseButton();
        } else {
          return replayButton();
        }
      },
    );
  }

  Widget seekBar() {
    return StreamBuilder<PositionData>(
      stream: controller.positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
          ),
          child: AudioSeekBarWidget(
            duration: positionData?.duration ?? Duration.zero,
            position: positionData?.position ?? Duration.zero,
            bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
            onChangeEnd: controller.player.seek,
            align: widget.align,
          ),
        );
      },
    );
  }

  Widget audioSpeed() {
    return Positioned(
      right: 10,
      top: 10,
      child: GestureDetector(
        onTap: () => controller.setAudioSpeed(),
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(color: SystemColors.neutralMediumSilver),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Obx(
              () => Text(
                controller.audioSpeedLabel.value,
                style: TextStyle(
                    color: widget.align == DSAlign.right
                        ? SystemColors.neutralLightSnow
                        : SystemColors.neutralDarkCity),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
