import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../blip_ds.dart';

class DSEndCallsMessageBubble extends StatelessWidget {
  final Uri uri;
  final DSAlign align;
  final List<DSBorderRadius> borderRadius;
  final DSMessageBubbleStyle style;
  final String? callStatus;
  final Function? onAsyncFetchSession;

  DSEndCallsMessageBubble({
    super.key,
    required this.uri,
    required this.align,
    this.borderRadius = const [DSBorderRadius.all],
    final DSMessageBubbleStyle? style,
    this.callStatus,
    this.onAsyncFetchSession,
  }) : style = style ?? DSMessageBubbleStyle();

  @override
  Widget build(BuildContext context) {
    final colorsText = style.isLightBubbleBackground(align)
        ? DSColors.neutralDarkCity
        : DSColors.neutralLightSnow;
    final colorsContainer = style.isLightBubbleBackground(align)
        ? DSColors.surface3
        : DSColors.neutralDarkDesk;
    final callRecordText = Rx<String>("Carregar gravação");
    final isLoadingRecording = Rx<bool>(false);

    return DSMessageBubble(
      borderRadius: borderRadius,
      align: align,
      style: style,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        (callStatus == 'confirmed' || callStatus == 'answered')
                            ? DSColors.success
                            : DSColors.error,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    (callStatus == 'confirmed' || callStatus == 'answered'
                        ? DSIcons.voip_calling_outline
                        : DSIcons.voip_ended_outline),
                    color: DSColors.contentDefault,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    DSHeadlineSmallText(
                      "Ligação",
                      color: colorsText,
                    ),
                    DSBodyText(
                      color: colorsText,
                      callStatus == 'confirmed' || callStatus == 'answered'
                          ? "Finalizada"
                          : (callStatus == 'rejected'
                              ? "Cancelada"
                              : "Não atendida"),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24.0,
                  ),
                  child: DSBodyText(
                    "+55 31 999999999",
                    color: colorsText,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: colorsContainer,
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (isLoadingRecording.value) const DSSpinnerLoading(),
                      DSBodyText(
                        callRecordText.value,
                        color: colorsText,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: DSColors.contentDefault,
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        child: Visibility(
                          visible: isLoadingRecording.value ? false : true,
                          child: IconButton(
                            onPressed: () async {
                              isLoadingRecording.value = true;
                              callRecordText.value = "Preparando gravação...";
                              //await onAsyncFetchSession();
                              await Future.delayed(const Duration(seconds: 3));
                              isLoadingRecording.value = false;
                              callRecordText.value = "Carregar gravação";
                            },
                            icon: const Icon(DSIcons.refresh_outline,
                                color: DSColors.neutralLightSnow),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
