import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../../blip_ds.dart';
import '../animations/ds_uploading.widget.dart';

class DSExpandedImage extends StatelessWidget {
  final String appBarText;
  final String url;
  final BoxFit fit;
  final double width;
  final double height;
  final bool isLoading;
  final Uri? appBarPhotoUri;
  final DSMessageBubbleStyle style;
  final DSAlign align;
  final bool shouldAuthenticate;
  final bool isUploading;

  final _error = RxBool(false);
  final _isAppBarVisible = RxBool(false);

  DSExpandedImage({
    super.key,
    required this.appBarText,
    required this.url,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = double.infinity,
    this.isLoading = false,
    this.appBarPhotoUri,
    this.shouldAuthenticate = false,
    DSMessageBubbleStyle? style,
    DSAlign? align,
    this.isUploading = false,
  })  : style = style ?? DSMessageBubbleStyle(),
        align = align ?? DSAlign.center;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: !isLoading,
        replacement: _buildLoading(),
        child: GestureDetector(
          onTap: () {
            if (!_error.value) {
              _isAppBarVisible.value = true;
              _expandImage();
            }
          },
          child: url.startsWith('http')
              ? DSCachedNetworkImageView(
                  fit: fit,
                  width: width,
                  height: height,
                  url: url,
                  placeholder: (_, __) => _buildLoading(),
                  onError: () => _error.value = true,
                  align: align,
                  style: style,
                  shouldAuthenticate: shouldAuthenticate,
                )
              : Stack(
                  children: [
                    Image.file(
                      File(url),
                      width: width,
                      height: height,
                      fit: fit,
                      cacheWidth: 360,
                      errorBuilder: (_, __, ___) => _defaultErrorWidget(),
                      opacity:
                          isUploading ? const AlwaysStoppedAnimation(.3) : null,
                    ),
                    Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: Visibility(
                        visible: isUploading,
                        child: const DSUploading(),
                      ),
                    ),
                  ],
                ),
        ),
      );

  Widget _defaultErrorWidget() {
    _error.value = true;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Icon(
              DSIcons.file_image_broken_outline,
              color: style.isLightBubbleBackground(align)
                  ? DSColors.neutralMediumElephant
                  : DSColors.neutralMediumCloud,
              size: 75,
            ),
          ),
        ),
      ],
    );
  }

  Future<T?> _expandImage<T>() => showGeneralDialog<T>(
        context: Get.context!,
        barrierDismissible: false,
        transitionDuration: DSUtils.defaultAnimationDuration,
        transitionBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        ),
        pageBuilder: (_, __, ___) => _buildPage(),
      );

  Widget _buildPage() => AnnotatedRegion<SystemUiOverlayStyle>(
        value: DSSystemOverlayStyle.light,
        child: Obx(
          () => Scaffold(
            backgroundColor: Colors.black,
            extendBodyBehindAppBar: true,
            appBar: DSHeader(
              showBorder: false,
              visible: _isAppBarVisible.value,
              title: appBarText,
              customerUri: appBarPhotoUri,
              customerName: appBarText,
              backgroundColor: Colors.black.withOpacity(0.7),
              onBackButtonPressed: Get.back,
              systemUiOverlayStyle: DSSystemOverlayStyle.light,
            ),
            body: GestureDetector(
              onTap: () => _isAppBarVisible.value = !_isAppBarVisible.value,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: PinchZoom(
                  child: url.startsWith('http')
                      ? DSCachedNetworkImageView(
                          url: url,
                          fit: BoxFit.contain,
                          placeholder: (context, _) => _buildLoading(),
                          align: align,
                          style: style,
                          shouldAuthenticate: shouldAuthenticate,
                        )
                      : Image.file(
                          File(url),
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildLoading() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: DSSpinnerLoading(
            color: style.isLightBubbleBackground(align)
                ? DSColors.primaryNight
                : DSColors.neutralLightSnow,
            size: 32.0,
            lineWidth: 4.0,
          ),
        ),
      );
}
