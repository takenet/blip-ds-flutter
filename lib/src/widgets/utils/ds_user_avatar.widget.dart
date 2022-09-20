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
            progressIndicatorBuilder: (context, url, downloadProgress) {
              final size = radius * 2;

              return SizedBox(
                height: size,
                width: size,
                child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 1),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : (text?.isNotEmpty ?? false)
            ? CircleAvatar(
                radius: radius,
                backgroundColor: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: DSBodyText(
                    RegExp(r'[A-Za-z]').allMatches(text!).map((m) => m.group(0)).join().toUpperCase(),
                    color: textColor,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
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
