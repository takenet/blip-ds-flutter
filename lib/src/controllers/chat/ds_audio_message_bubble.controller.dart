import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;

class DSAudioMessageBubbleController extends GetxController {
  final audioSpeed = RxDouble(1.0);
  final audioSpeedLabel = RxString('x1');

  final player = AudioPlayer();

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get positionDataStream =>
      rx_dart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  void setAudioSpeed() {
    if (audioSpeed.value == 1) {
      audioSpeed.value = 1.5;
      audioSpeedLabel.value = 'x1.5';
    } else if (audioSpeed.value == 1.5) {
      audioSpeed.value = 2.0;
      audioSpeedLabel.value = 'x2';
    } else {
      audioSpeed.value = 1.0;
      audioSpeedLabel.value = 'x1';
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
