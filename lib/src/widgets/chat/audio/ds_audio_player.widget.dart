import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';

import '../../../controllers/chat/ds_audio_player.controller.dart';
import '../../../extensions/future.extension.dart';
import '../../../services/ds_auth.service.dart';
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
      await _loadAudio().trueWhile(
        _controller.isLoadingAudio,
      );

      _controller.isInitialized.value = true;
    } catch (_) {
      _controller.isInitialized.value = false;
    }
  }

  Future<void> _loadAudio() async {
    if (!widget.uri.scheme.startsWith('http')) {
      await _controller.player.setAudioSource(
        AudioSource.uri(
          widget.uri,
        ),
      );

      return;
    }

    var outputPath = await DSDirectoryFormatter.getCachePath(
      type: 'audio',
      filename: md5.convert(utf8.encode(widget.uri.path)).toString(),
    );

    var outputDirectory = Directory(
      outputPath.substring(
        0,
        outputPath.lastIndexOf('/'),
      ),
    );

    if (outputDirectory.existsSync()) {
      final allFiles = outputDirectory.listSync();

      final fileSearched = allFiles.firstWhereOrNull(
        (file) =>
            basenameWithoutExtension(file.path) ==
            basenameWithoutExtension(outputPath),
      );

      outputPath = fileSearched?.path ?? outputPath;
    }

    File outputFile = File(outputPath);
    var hasCachedFile = outputFile.existsSync();

    if (!hasCachedFile) {
      outputPath = await _downloadAudio(
        outputPath: outputPath,
      );

      outputFile = File(outputPath);
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

  Future<String> _downloadAudio({
    required String outputPath,
  }) async {
    final tempPath = await DSFileService.download(
      url: widget.uri.toString(),
      httpHeaders: widget.shouldAuthenticate ? DSAuthService.httpHeaders : null,
    );

    if (tempPath?.isNotEmpty ?? false) {
      final tempFile = File(tempPath!);
      outputPath += extension(tempPath);

      if (tempFile.existsSync()) {
        tempFile.copySync(outputPath);
        tempFile.deleteSync();
      }
    }

    return outputPath;
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
                        .contains(processingState) ||
                    _controller.isLoadingAudio.value,
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
