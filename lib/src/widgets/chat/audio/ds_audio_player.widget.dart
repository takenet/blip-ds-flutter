import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../controllers/chat/ds_audio_player.controller.dart';
import '../../../services/ds_auth.service.dart';
import '../../../services/ds_ffmpeg.service.dart';
import '../../../services/ds_file.service.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../utils/ds_directory_formatter.util.dart';
import '../../buttons/ds_pause_button.widget.dart';
import '../../buttons/ds_play_button.widget.dart';
import 'ds_audio_seek_bar.widget.dart';
import 'ds_audio_speed_button.widget.dart';

class DSAudioPlayer extends StatefulWidget {
  final Uri uri;
  final Color labelColor;
  final Color bufferActiveTrackColor;
  final Color bufferInactiveTrackColor;
  final Color sliderActiveTrackColor;
  final Color sliderThumbColor;
  final Color controlForegroundColor;
  final Color speedForegroundColor;
  final Color speedBorderColor;
  final bool shouldAuthenticate;

  const DSAudioPlayer({
    super.key,
    required this.uri,
    required this.labelColor,
    required this.bufferActiveTrackColor,
    required this.bufferInactiveTrackColor,
    required this.sliderActiveTrackColor,
    required this.sliderThumbColor,
    required this.controlForegroundColor,
    required this.speedForegroundColor,
    required this.speedBorderColor,
    this.shouldAuthenticate = false,
  });

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
    _controller.player.playerStateStream.listen(
      (event) {
        if (event.processingState == ProcessingState.completed) {
          _controller.player.seek(Duration.zero);
          _controller.player.stop();
        }
      },
    );

    try {
      await _loadAudio();

      _controller.isInitialized.value = true;
    } catch (_) {
      _controller.isInitialized.value = false;
    }
  }

  Future<void> _loadAudio() async {
    final outputPath = await DSDirectoryFormatter.getCachePath(
      type: 'audio/mp4',
      filename: md5.convert(utf8.encode(widget.uri.path)).toString(),
      extension: 'm4a',
    );

    final outputFile = File(outputPath);
    var hasCachedFile = outputFile.existsSync();

    if (!hasCachedFile) {
      await _downloadAudio(
        outputPath: outputPath,
      );

      hasCachedFile = outputFile.existsSync();
    }

    await _controller.player.setAudioSource(
      hasCachedFile
          ? AudioSource.file(
              outputPath,
            )
          : AudioSource.uri(
              widget.uri,
              headers:
                  widget.shouldAuthenticate ? DSAuthService.httpHeaders : null,
            ),
    );
  }

  Future<void> _downloadAudio({
    required final String outputPath,
  }) async {
    final tempPath = await DSFileService.download(
      url: widget.uri.toString(),
      httpHeaders: widget.shouldAuthenticate ? DSAuthService.httpHeaders : null,
    );

    if (tempPath?.isNotEmpty ?? false) {
      final isSuccess = await DSFFmpegService.transcodeAudio(
        input: tempPath!,
        output: outputPath,
      );

      final tempFile = File(tempPath);

      if (tempFile.existsSync()) {
        tempFile.deleteSync();
      }

      if (!isSuccess) {
        final outputFile = File(outputPath);

        if (outputFile.existsSync()) {
          outputFile.deleteSync();
        }
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
            return Obx(
              () => DSPlayButton(
                onPressed: _controller.isInitialized.value
                    ? _controller.player.play
                    : () => {},
                isLoading: [ProcessingState.loading, ProcessingState.buffering]
                    .contains(processingState),
                color: _controller.isInitialized.value
                    ? widget.controlForegroundColor
                    : DSColors.contentDisable,
              ),
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
        return Obx(
          () => DSAudioSeekBar(
            duration: positionData?.duration ?? Duration.zero,
            position: positionData?.position ?? Duration.zero,
            bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
            onChangeEnd: _controller.isInitialized.value
                ? _controller.player.play
                : null,
            onChanged: _controller.isInitialized.value
                ? _controller.player.seek
                : null,
            onChangeStart: _controller.player.pause,
            labelColor: widget.labelColor,
            bufferActiveTrackColor: widget.bufferActiveTrackColor,
            bufferInactiveTrackColor: widget.bufferInactiveTrackColor,
            sliderActiveTrackColor: widget.sliderActiveTrackColor,
            sliderThumbColor: widget.sliderThumbColor,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
