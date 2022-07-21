import 'package:blip_ds/blip_ds.dart';
import 'package:blip_ds/src/controllers/chat/ds_image_message_bubble.controller.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DSImageMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String url;
  final List<DSBorderRadius> borderRadius;
  final String title;
  final String subtitle;

  final DSImageMessageBubbleController _controller;

  DSImageMessageBubble({
    Key? key,
    required this.align,
    required this.url,
    this.borderRadius = const [DSBorderRadius.all],
    required this.title,
    this.subtitle = "",
  })  : _controller = DSImageMessageBubbleController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      contentPadding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (!_controller.error.value) {
                final imageProvider = Image.network(
                  url,
                ).image;
                showImageViewer(
                  context,
                  imageProvider,
                );
              }
            },
            child: CachedNetworkImage(
              width: 240.0,
              height: 240.0,
              fit: BoxFit.fill,
              imageUrl: url,
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(80.0),
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) {
                _controller.setError();
                return Image.asset('images/file-image-broken.png');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: align == DSAlign.right
                        ? SystemColors.neutralLightSnow
                        : SystemColors.neutralDarkCity,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: align == DSAlign.right
                          ? SystemColors.neutralLightSnow
                          : SystemColors.neutralDarkCity,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
