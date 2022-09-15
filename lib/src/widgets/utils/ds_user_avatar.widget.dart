import 'package:blip_ds/blip_ds.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DSUserAvatar extends StatelessWidget {
  final String? text;
  final Uri? uri;
  final double radius;
  final Color backgroundColor;
  final Color textColor;

  const DSUserAvatar({
    Key? key,
    this.text,
    this.uri,
    this.radius = 25.0,
    this.backgroundColor = DSColors.primaryGreensTrue,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return uri != null
        ? CachedNetworkImage(
            imageUrl: uri.toString(),
            imageBuilder: (context, image) => CircleAvatar(
              radius: radius,
              backgroundColor: backgroundColor,
              backgroundImage: image,
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : (text?.isNotEmpty ?? false)
            ? CircleAvatar(
                radius: radius,
                backgroundColor: backgroundColor,
                child: DSBodyText(
                  RegExp(r'\b[A-a-Z-z]').allMatches(text!).map((m) => m.group(0)).join().toUpperCase(),
                  color: textColor,
                ),
              )
            : CircleAvatar(
                radius: radius,
                backgroundColor: backgroundColor,
                backgroundImage: const AssetImage(
                  'assets/images/avatar-default.png',
                ),
              );
  }
}
