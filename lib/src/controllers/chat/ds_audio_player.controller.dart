import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;

class DSAudioPlayerController extends GetxController {
  final audioSpeed = RxDouble(1.0);
  final player = AudioPlayer();
  final isInitialized = RxBool(false);

  /// Collects the data useful for displaying in a SeekBar widget.
  ///
  /// Uses a useful feature of rx_dart to combine the 3 streams of interest into one.
  /// Returns a PositionData with three Position objects.
  Stream<PositionData> get positionDataStream =>
      rx_dart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  void setAudioSpeed() {
    if (audioSpeed.value == 1 || audioSpeed.value == 1.5) {
      audioSpeed.value += 0.5;
    } else {
      audioSpeed.value = 1.0;
    }
    player.setSpeed(audioSpeed.value);
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
