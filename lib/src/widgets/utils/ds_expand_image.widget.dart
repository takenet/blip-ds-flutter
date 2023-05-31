import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../../blip_ds.dart';

abstract class DSExpandImage {
  static Future<T?> expandImage<T>({
    required BuildContext context,
    required bool isAppBarVisible,
    required String appBarText,
    required VoidCallback onTap,
    required String url,
    required DSAlign align,
    required DSMessageBubbleStyle style,
    Uri? appBarPhotoUri,
  }) =>
      showGeneralDialog<T>(
        context: context,
        barrierDismissible: false,
        transitionDuration: DSUtils.defaultAnimationDuration,
        transitionBuilder: (_, animation, __, child) =>
            _buildTransition(animation, child),
        pageBuilder: (context, _, __) => _buildPage(
          context: context,
          isAppBarVisible: isAppBarVisible,
          appBarText: appBarText,
          appBarPhotoUri: appBarPhotoUri,
          onTap: onTap,
          url: url,
          align: align,
          style: style,
        ),
      );

  static Widget _buildTransition(Animation<double> animation, Widget? child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  static Widget _buildPage({
    required BuildContext context,
    required bool isAppBarVisible,
    required String appBarText,
    required VoidCallback onTap,
    required String url,
    required DSAlign align,
    required DSMessageBubbleStyle style,
    Uri? appBarPhotoUri,
  }) {
    const overlayStyle = DSSystemOverlayStyle.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: DSHeader(
          showBorder: false,
          visible: isAppBarVisible,
          title: appBarText,
          customerUri: appBarPhotoUri,
          customerName: appBarText,
          backgroundColor: Colors.black.withOpacity(0.7),
          onBackButtonPressed: Get.back,
          systemUiOverlayStyle: overlayStyle,
        ),
        body: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: PinchZoom(
              child: DSCachedNetworkImageView(
                url: url,
                fit: BoxFit.contain,
                placeholder: (context, _) => buildLoading(
                  style: style,
                  align: align,
                ),
                align: align,
                style: style,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildLoading({
    required DSMessageBubbleStyle style,
    required DSAlign align,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Center(
            child: DSSpinnerLoading(
              color: style.isLightBubbleBackground(align)
                  ? DSColors.primaryNight
                  : DSColors.neutralLightSnow,
              size: 32.0,
              lineWidth: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}
