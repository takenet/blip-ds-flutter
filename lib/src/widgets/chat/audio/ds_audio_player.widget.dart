import 'dart:io';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import '../../../controllers/chat/ds_audio_player.controller.dart';
import '../../../models/ds_toast_props.model.dart';
import '../../../services/ds_auth.service.dart';
import '../../../services/ds_file.service.dart';
import '../../../services/ds_toast.service.dart';
import '../../buttons/ds_pause_button.widget.dart';
import '../../buttons/ds_play_button.widget.dart';
import 'ds_audio_seek_bar.widget.dart';
import 'ds_audio_speed_button.widget.dart';

class DSAudioPlayer extends StatefulWidget {
  final Uri uri;
  final String uniqueId;
  final String audioType;
  final Color labelColor;
  final Color bufferActiveTrackColor;
  final Color bufferInactiveTrackColor;
  final Color sliderActiveTrackColor;
  final Color sliderThumbColor;
  final Color controlForegroundColor;
  final Color speedForegroundColor;
  final Color speedBorderColor;
  final bool shouldAuthenticate;

  DSAudioPlayer({
    super.key,
    required this.uri,
    required this.audioType,
    required this.labelColor,
    required this.bufferActiveTrackColor,
    required this.bufferInactiveTrackColor,
    required this.sliderActiveTrackColor,
    required this.sliderThumbColor,
    required this.controlForegroundColor,
    required this.speedForegroundColor,
    required this.speedBorderColor,
    this.shouldAuthenticate = false,
    final String? uniqueId,
  }) : uniqueId = uniqueId ?? DateTime.now().toIso8601String();

  @override
  State<DSAudioPlayer> createState() => _DSAudioPlayerState();
}

class _DSAudioPlayerState extends State<DSAudioPlayer>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final _controller = DSAudioPlayerController();

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
    super.build(context);

    return SizedBox(
      height: 52.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
              ),
              child: _seekBar(),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: _controlButtons(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _buildSpeedButton(),
          ),
        ],
      ),
    );
  }

  Future<void> _init() async {
    try {
      _controller.player.playerStateStream.listen(
        (event) {
          if (event.processingState == ProcessingState.completed) {
            _controller.player.seek(Duration.zero);
            _controller.player.stop();
          }
        },
      );

      Platform.isIOS && widget.audioType.contains('ogg')
          ? await _transcoder()
          : await _controller.player.setAudioSource(
              AudioSource.uri(
                widget.uri,
                headers: widget.shouldAuthenticate
                    ? DSAuthService.httpHeaders
                    : null,
              ),
            );
    } catch (_) {
      // TODO: translate
      DSToastService.error(
        DSToastProps(
          title: 'Erro ao reproduzir áudio',
          message: 'Ops! Houve um erro ao carregar o áudio para reprodução.',
        ),
      );
    }
  }

  Future<void> _transcoder() async {
    final inputFileName = 'AUDIO-${widget.uniqueId}.ogg';

    final inputFilePath = await DSFileService.download(
      widget.uri.toString(),
      inputFileName,
      httpHeaders: widget.shouldAuthenticate ? DSAuthService.httpHeaders : null,
    );

    final temporaryPath = (await getTemporaryDirectory()).path;
    final outputFile = File("$temporaryPath/AUDIO-${widget.uniqueId}.mp3");

    if (await outputFile.exists()) {
      await _controller.player.setFilePath(outputFile.path);
    } else {
      final session = await FFmpegKit.execute(
        '-hide_banner -y -i "$inputFilePath" -c:a libmp3lame -qscale:a 2 "${outputFile.path}"',
      );

      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        await _controller.player.setFilePath(outputFile.path);
      }
    }
  }

  Widget _buildSpeedButton() => Obx(
        () => DSAudioSpeedButton(
          text:
              "x${_controller.audioSpeed.value.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '')}",
          onTap: _controller.setAudioSpeed,
          color: widget.speedForegroundColor,
          borderColor: widget.speedBorderColor,
        ),
      );

  Widget _controlButtons() => StreamBuilder<PlayerState>(
        stream: _controller.player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (playing != true) {
            return DSPlayButton(
              onPressed: _controller.player.play,
              isLoading: [ProcessingState.loading, ProcessingState.buffering]
                  .contains(processingState),
              color: widget.controlForegroundColor,
            );
          } else if (processingState != ProcessingState.completed) {
            return DSPauseButton(
              onPressed: _controller.player.pause,
              color: widget.controlForegroundColor,
            );
          } else {
            return const SizedBox();
          }
        },
      );

  Widget _seekBar() {
    return StreamBuilder<PositionData>(
      stream: _controller.positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return DSAudioSeekBar(
          duration: positionData?.duration ?? Duration.zero,
          position: positionData?.position ?? Duration.zero,
          bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
          onChangeEnd: _controller.player.play,
          onChanged: _controller.player.seek,
          onChangeStart: _controller.player.pause,
          labelColor: widget.labelColor,
          bufferActiveTrackColor: widget.bufferActiveTrackColor,
          bufferInactiveTrackColor: widget.bufferInactiveTrackColor,
          sliderActiveTrackColor: widget.sliderActiveTrackColor,
          sliderThumbColor: widget.sliderThumbColor,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
