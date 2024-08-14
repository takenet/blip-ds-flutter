import 'dart:async';

import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../enums/ds_border_radius.enum.dart';
import '../../extensions/ds_localization.extension.dart';
import '../../extensions/ds_string.extension.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../animations/ds_spinner_loading.widget.dart';
import '../buttons/ds_button.widget.dart';
import '../texts/ds_caption_small_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import 'audio/ds_audio_player.widget.dart';
import 'ds_message_bubble.widget.dart';

class DSEndCallsMessageBubble extends StatelessWidget {
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final Map<String, dynamic> content;
  final Future<String?> Function(String)? onAsyncFetchSession;
  final StreamController _streamController = StreamController<bool>();
  final Map<String, dynamic>? translations;

  bool get _isCallAnswered => ['completed', 'answer'].contains(
        content['status'].toString().toLowerCase(),
      );

  bool get _isInbound =>
      content['direction'].toString().toLowerCase() == 'inbound';

  bool get _isLightBubbleBackground => style.isLightBubbleBackground(align);
  bool get _isDefaultBubbleColors => style.isDefaultBubbleBackground(align);

  Color get _foregroundColor => _isLightBubbleBackground
      ? DSColors.neutralDarkCity
      : DSColors.neutralLightSnow;

  DSEndCallsMessageBubble({
    super.key,
    required this.align,
    required this.content,
    required this.onAsyncFetchSession,
    this.borderRadius = const [DSBorderRadius.all],
    DSMessageBubbleStyle? style,
    this.translations,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      borderRadius: borderRadius,
      align: align,
      style: style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _isCallAnswered
                                    ? DSColors.success
                                    : DSColors.error,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    8.0,
                                  ),
                                ),
                              ),
                              width: 30,
                              height: 30,
                              child: Icon(
                                _isCallAnswered
                                    ? _isInbound
                                        ? DSIcons.voip_receiving_outline
                                        : DSIcons.voip_calling_outline
                                    : DSIcons.voip_ended_outline,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DSCaptionText(
                            'calls.voice-text'.translate(),
                            fontWeight: FontWeight.bold,
                            color: _foregroundColor,
                          ),
                          DSCaptionSmallText(
                            _isCallAnswered
                                ? 'calls.answered'.translate()
                                : 'calls.unanswered'.translate(),
                            color: _foregroundColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  children: [
                    FutureBuilder(
                      future:
                          content['identification'].toString().asPhoneNumber(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return DSCaptionSmallText(
                            snapshot.data,
                            color: _foregroundColor,
                          );
                        }
                        return const DSSpinnerLoading();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          if (_isCallAnswered && onAsyncFetchSession != null)
            StreamBuilder(
              stream: _streamController.stream,
              builder: (_, __) {
                return FutureBuilder<String?>(
                  future: onAsyncFetchSession!(
                    content['sessionId'],
                  ),
                  builder: (_, snapshot) {
                    return switch (snapshot.connectionState) {
                      ConnectionState.waiting => _buildLoading(),
                      ConnectionState.done => snapshot.hasError
                          ? _buildError()
                          : snapshot.data?.isEmpty ?? true
                              ? const SizedBox.shrink()
                              : _buildAudioPlayer(snapshot.data!),
                      _ => const SizedBox.shrink(),
                    };
                  },
                );
              },
            )
        ],
      ),
    );
  }

  Widget _buildContainer(final Widget child) => SizedBox(
        height: 60.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: _isLightBubbleBackground
                  ? DSColors.neutralLightWhisper
                  : DSColors.neutralDarkDesk,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
            child: child,
          ),
        ),
      );

  Widget _buildAudioPlayer(final String data) => _buildContainer(
        Padding(
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

  Widget _buildLoading() => _buildContainer(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const DSSpinnerLoading(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DSCaptionText(
                  'calls.preparing-record'.translate(),
                  color: _foregroundColor,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildError() => _buildContainer(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DSCaptionText(
                'calls.load-record'.translate(),
                color: _foregroundColor,
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
                  size: 25.0,
                ),
                autoSize: true,
              )
            ],
          ),
        ),
      );
}
