import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../blip_ds.dart';
import '../../buttons/ds_rounded_play_button.widget.dart';

class DSVideoBody extends StatelessWidget {
  const DSVideoBody({
    super.key,
    required this.align,
    required this.appBarText,
    required this.appBarPhotoUri,
    required this.url,
    required this.uniqueId,
    required this.thumbnail,
  });
  final DSAlign align;
  final String appBarText;
  final Uri? appBarPhotoUri;
  final String url;
  final String uniqueId;
  final String thumbnail;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Image.file(
            File(
              thumbnail,
            ),
            width: 240,
            height: 240,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: DSRoundedPlayButton(
            align: align,
            onPressed: () async {
              await showGeneralDialog(
                context: context,
                barrierDismissible: false,
                transitionDuration: DSUtils.defaultAnimationDuration,
                transitionBuilder: (_, animation, __, child) =>
                    _buildTransition(animation, child),
                pageBuilder: (context, _, __) => DSVideoPlayer(
                  appBarText: appBarText,
                  appBarPhotoUri: appBarPhotoUri,
                  url: url,
                  uniqueId: uniqueId,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransition(Animation<double> animation, Widget? child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
