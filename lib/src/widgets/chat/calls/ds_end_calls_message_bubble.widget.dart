import 'dart:async';

import 'package:flutter/material.dart';

import '../../../enums/ds_align.enum.dart';
import '../../../enums/ds_border_radius.enum.dart';
import '../../../enums/ds_call_direction.enum.dart';
import '../../../enums/ds_call_status.enum.dart';
import '../../../extensions/ds_localization.extension.dart';
import '../../../extensions/ds_string.extension.dart';
import '../../../models/ds_calls_media_message.model.dart';
import '../../../models/ds_message_bubble_style.model.dart';
import '../../../themes/colors/ds_colors.theme.dart';
import '../../../themes/icons/ds_icons.dart';
import '../../../themes/texts/utils/ds_font_weights.theme.dart';
import '../../animations/ds_spinner_loading.widget.dart';
import '../../buttons/ds_button.widget.dart';
import '../../texts/ds_caption_small_text.widget.dart';
import '../../texts/ds_caption_text.widget.dart';
import '../../texts/ds_headline_small_text.widget.dart';
import '../audio/ds_audio_player.widget.dart';
import '../ds_message_bubble.widget.dart';
import 'ds_end_calls_recording_container.widget.dart';

class DSEndCallsMessageBubble extends StatefulWidget {
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final DSCallsMediaMessage callsMediaMessage;
  final Future<String?> Function(String)? onAsyncFetchSession;
  final Map<String, dynamic>? translations;

  DSEndCallsMessageBubble({
    super.key,
    required this.align,
    required this.callsMediaMessage,
    required this.onAsyncFetchSession,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
    this.translations,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  State<DSEndCallsMessageBubble> createState() =>
      _DSEndCallsMessageBubbleState();
}

class _DSEndCallsMessageBubbleState extends State<DSEndCallsMessageBubble> {
  final StreamController _streamController = StreamController<bool>();
  late final Future<String> _phoneNumber;
  Future<String?> Function(String)? _onAsyncfetchsession;

  bool get _isCallAnswered =>
      [DSCallStatus.completed, DSCallStatus.answer].contains(
        widget.callsMediaMessage.status,
      );

  bool get _isInbound =>
      widget.callsMediaMessage.direction == DSCallDirection.inbound;

  bool get _isLightBubbleBackground =>
      widget.style.isLightBubbleBackground(widget.align);

  bool get _isDefaultBubbleColors =>
      widget.style.isDefaultBubbleBackground(widget.align);

  Color get _foregroundColor => _isLightBubbleBackground
      ? DSColors.neutralDarkCity
      : DSColors.neutralLightSnow;

  @override
  void initState() {
    super.initState();
    _phoneNumber =
        widget.callsMediaMessage.identification.toString().asPhoneNumber();
    _onAsyncfetchsession = widget.onAsyncFetchSession;
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 10.0,
      ),
      borderRadius: widget.borderRadius,
      align: widget.align,
      style: widget.style,
      child: Column(
        children: [
          _buildCallInfo(),
          _buildMediaPlayer(),
        ],
      ),
    );
  }

  Widget _buildCallInfo() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _isCallAnswered ? DSColors.success : DSColors.error,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        8.0,
                      ),
                    ),
                  ),
                  width: 40,
                  height: 40,
                  child: Icon(
                    _isCallAnswered
                        ? _isInbound
                            ? DSIcons.voip_receiving_outline
                            : DSIcons.voip_calling_outline
                        : DSIcons.voip_ended_outline,
                    size: 24.0,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DSHeadlineSmallText(
                    'calls.voice-text'.translate(),
                    color: _foregroundColor,
                  ),
                  DSCaptionText(
                    _isCallAnswered
                        ? 'calls.answered'.translate()
                        : 'calls.unanswered'.translate(),
                    color: _foregroundColor,
                    fontWeight: DSFontWeights.semiBold,
                  ),
                ],
              ),
            ],
          ),
          Flexible(
            child: FutureBuilder(
              future: _phoneNumber,
              builder: (_, snapshot) {
                if (snapshot.hasData && !snapshot.hasError) {
                  return DSCaptionSmallText(
                    snapshot.data,
                    color: _foregroundColor,
                  );
                }
                return const DSSpinnerLoading();
              },
            ),
          ),
        ],
      );

  Widget _buildMediaPlayer() => _isCallAnswered && _onAsyncfetchsession != null
      ? StreamBuilder(
          stream: _streamController.stream,
          builder: (_, __) {
            return FutureBuilder<String?>(
              future: _onAsyncfetchsession!(
                widget.callsMediaMessage.sessionId,
              ),
              builder: (_, snapshot) {
                return switch (snapshot.connectionState) {
                  ConnectionState.done => snapshot.hasError
                      ? _buildError()
                      : snapshot.data?.isEmpty ?? true
                          ? const SizedBox.shrink()
                          : _buildAudioPlayer(snapshot.data!),
                  _ => _buildLoading(),
                };
              },
            );
          },
        )
      : const SizedBox.shrink();

  Widget _buildAudioPlayer(final String data) => DSEndCallsRecordingContainer(
        isLighBubbleBackground: _isLightBubbleBackground,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: DSAudioPlayer(
            uri: Uri.parse(data),
            controlForegroundColor: _isLightBubbleBackground
                ? DSColors.neutralDarkRooftop
                : DSColors.neutralLightSnow,
            labelColor: _isLightBubbleBackground
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
            bufferActiveTrackColor: _isLightBubbleBackground
                ? DSColors.neutralMediumWave
                : DSColors.neutralMediumElephant,
            bufferInactiveTrackColor: _isLightBubbleBackground
                ? DSColors.neutralDarkRooftop
                : DSColors.neutralLightBox,
            sliderActiveTrackColor: _isLightBubbleBackground
                ? DSColors.primaryNight
                : DSColors.primaryLight,
            sliderThumbColor: _isLightBubbleBackground
                ? DSColors.neutralDarkRooftop
                : DSColors.neutralLightSnow,
            speedForegroundColor: _isLightBubbleBackground
                ? DSColors.neutralDarkCity
                : DSColors.neutralLightSnow,
            speedBorderColor: _isLightBubbleBackground
                ? _isDefaultBubbleColors
                    ? DSColors.neutralMediumSilver
                    : DSColors.neutralDarkCity
                : _isDefaultBubbleColors
                    ? DSColors.disabledText
                    : DSColors.neutralLightSnow,
          ),
        ),
      );

  Widget _buildLoading() => DSEndCallsRecordingContainer(
        isLighBubbleBackground: _isLightBubbleBackground,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const DSSpinnerLoading(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DSCaptionText(
                  'calls.preparing-record'.translate(),
                  color: _foregroundColor,
                  fontWeight: DSFontWeights.semiBold,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildError() => DSEndCallsRecordingContainer(
        isLighBubbleBackground: _isLightBubbleBackground,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DSCaptionText(
                'calls.load-record'.translate(),
                color: _foregroundColor,
                fontWeight: DSFontWeights.semiBold,
              ),
              DSButton(
                onPressed: () => _streamController.add(true),
                borderColor: _isLightBubbleBackground
                    ? DSColors.neutralMediumSilver
                    : DSColors.disabledText,
                foregroundColor: _isLightBubbleBackground
                    ? DSColors.neutralDarkCity
                    : DSColors.neutralLightSnow,
                backgroundColor: _isLightBubbleBackground
                    ? DSColors.neutralLightWhisper
                    : DSColors.neutralDarkDesk,
                trailingIcon: const Icon(
                  DSIcons.refresh_outline,
                  size: 24.0,
                ),
                autoSize: true,
              )
            ],
          ),
        ),
      );
}
