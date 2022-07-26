import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DSCachedNetworkImageView extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final BoxFit fix;
  final Function placeholder;
  final Function errorWidget;

  const DSCachedNetworkImageView({
    Key? key,
    required this.url,
    required this.placeholder,
    required this.errorWidget,
    this.width = 0,
    this.height = 0,
    this.fix = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        width: width == 0 ? null : width,
        height: height == 0 ? null : height,
        fit: fix,
        imageUrl: url,
        placeholder: (context, url) => placeholder(context, url),
        errorWidget: (context, url, error) => errorWidget(context, url, error));
  }
}
