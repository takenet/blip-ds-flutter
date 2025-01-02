import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/ds_media_link.model.dart';
import '../../utils/ds_utils.util.dart';
import '../texts/ds_caption_small_text.widget.dart';

class DSAudioDurationView extends StatefulWidget {
  const DSAudioDurationView({
    super.key,
    required this.media,
    required this.foreground,
  });

  final DSMediaLink media;
  final Color foreground;

  @override
  createState() => _DSAudioDurationViewState();
}

class _DSAudioDurationViewState extends State<DSAudioDurationView> {
  final audioPlayer = AudioPlayer();
  final subtitle = ValueNotifier('');

  late final _mediaLink = widget.media;
  late final _foregroundColor = widget.foreground;

  @override
  void initState() {
    super.initState();

    _loadAudioDuration();
  }

  @override
  dispose() {
    audioPlayer.dispose();
    subtitle.dispose();

    super.dispose();
  }

  Future<void> _loadAudioDuration() async {
    try {
      await audioPlayer.setUrl(_mediaLink.previewUri ?? _mediaLink.uri);

      final duration = audioPlayer.duration;
      subtitle.value = RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
              .firstMatch("$duration")
              ?.group(1) ??
          "$duration";
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: subtitle,
      builder: (_, value, __) => AnimatedSwitcher(
        duration: DSUtils.defaultAnimationDuration,
        child: value.isNotEmpty
            ? DSCaptionSmallText(
                value,
                color: _foregroundColor,
                height: 1.0,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
