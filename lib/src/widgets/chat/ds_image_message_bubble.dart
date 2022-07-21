import 'package:blip_ds/blip_ds.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DSImageMessageBubble extends StatelessWidget {
  final DSAlign align;
  final String url;
  final List<DSBorderRadius> borderRadius;

  const DSImageMessageBubble({
    Key? key,
    required this.align,
    required this.url,
    this.borderRadius = const [DSBorderRadius.all],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSMessageBubble(
      align: align,
      borderRadius: borderRadius,
      contentPadding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: "http://via.placeholder.com/200x150",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [Text('a'), Text('a')],
            ),
          ),
        ],
      ),
    );
  }
}
