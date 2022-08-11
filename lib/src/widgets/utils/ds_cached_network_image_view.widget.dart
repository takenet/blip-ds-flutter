import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DSCachedNetworkImageView extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  final Widget Function(
    BuildContext context,
    String url,
  )? placeholder;

  final Widget Function(
    BuildContext context,
    String url,
    dynamic error,
  )? errorWidget;

  const DSCachedNetworkImageView({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: url.isEmpty
          ? _buildError(context)
          : CachedNetworkImage(
              fit: fit,
              imageUrl: url,
              placeholder: placeholder,
              errorWidget: errorWidget,
            ),
    );
  }

  Widget _buildError(BuildContext context) {
    return errorWidget != null
        ? errorWidget!(context, url, null)
        : const SizedBox();
  }
}
