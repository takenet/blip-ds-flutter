import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../blip_ds.dart';
import '../../../enums/ds_call_direction.enum.dart';
import '../../../enums/ds_call_status.enum.dart';
import '../../../extensions/ds_localization.extension.dart';
import 'ds_end_calls_recording_container.widget.dart';

class DSEndCallsMessageBubble extends StatefulWidget {
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final DSCallsMediaMessage callsMediaMessage;
  final Future<String?> Function(String)? onAsyncFetchSession;
  final Map<String, dynamic>? translations;
  final void Function(String)? onTapReply;

  DSEndCallsMessageBubble({
    super.key,
    required this.align,
    required this.callsMediaMessage,
    required this.onAsyncFetchSession,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
    this.translations,
    this.onTapReply,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  State<DSEndCallsMessageBubble> createState() =>
      _DSEndCallsMessageBubbleState();
}

class _DSEndCallsMessageBubbleState extends State<DSEndCallsMessageBubble> {
  final StreamController _streamController = StreamController<bool>.broadcast();
  late final Future<String> _phoneNumber;
  Future<String?>? _session;

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

    _session = widget.callsMediaMessage.sessionId != null
        ? widget.onAsyncFetchSession?.call(
            widget.callsMediaMessage.sessionId!,
          )
        : Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      onTapReply: widget.onTapReply,
      shouldUseDefaultSize: true,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 12.0,
      ),
      borderRadius: widget.borderRadius,
      align: widget.align,
      style: widget.style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCallInfo(),
          _buildMediaPlayer(),
        ],
      ),
    );
  }

  Widget _buildCallInfo() => Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
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
                    color: DSColors.neutralDarkCity,
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
              )
            ],
          ),
          FutureBuilder(
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
        ],
      );

  Widget _buildMediaPlayer() => _isCallAnswered && _session != null
      ? StreamBuilder(
          stream: _streamController.stream,
          builder: (_, __) {
            return DSAnimatedSize(
              child: FutureBuilder<String?>(
                future: _session,
                builder: (_, snapshot) {
                  Widget child;

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        child = _buildError();
                      } else if (DSUtils.shouldShowCallRecordingAudioPlayer &&
                          (snapshot.data?.isNotEmpty ?? false)) {
                        child = _buildAudioPlayer(snapshot.data!);
                      } else {
                        return const SizedBox.shrink();
                      }
                      break;

                    default:
                      child = _buildLoading();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: child,
                  );
                },
              ),
            );
          },
        )
      : const SizedBox.shrink();

  Widget _buildAudioPlayer(final String data) => DSEndCallsRecordingContainer(
        isLighBubbleBackground: _isLightBubbleBackground,
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
      );

  Widget _buildLoading() => DSEndCallsRecordingContainer(
        isLighBubbleBackground: _isLightBubbleBackground,
        child: Row(
          children: [
            const DSSpinnerLoading(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: DSBodyText(
                'calls.preparing-record'.translate(),
                color: _foregroundColor,
                fontWeight: DSFontWeights.semiBold,
              ),
            ),
          ],
        ),
      );

  Widget _buildError() => DSEndCallsRecordingContainer(
        isLighBubbleBackground: _isLightBubbleBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DSBodyText(
              'calls.load-record'.translate(),
              color: _foregroundColor,
              fontWeight: DSFontWeights.semiBold,
            ),
            DSGhostButton(
              onPressed: () => _streamController.add(true),
              borderColor: _isLightBubbleBackground
                  ? DSColors.neutralMediumSilver
                  : DSColors.disabledText,
              foregroundColor: _isLightBubbleBackground
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
              trailingIcon: const Icon(
                DSIcons.refresh_outline,
                size: 24.0,
              ),
              autoSize: true,
            )
          ],
        ),
      );
}
