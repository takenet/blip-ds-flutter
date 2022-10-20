import 'package:blip_ds/blip_ds.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DSCachedNetworkImageView extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final void Function()? onError;
  final DSAlign align;
  final DSMessageBubbleStyle style;

  final Widget Function(
    BuildContext context,
    String url,
  )? placeholder;

  final Widget Function(
    BuildContext context,
    String url,
    dynamic error,
  )? errorWidget;

  DSCachedNetworkImageView({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.onError,
    required this.align,
    DSMessageBubbleStyle? style,
  })  : style = style ?? DSMessageBubbleStyle(),
        super(key: key);

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
              errorWidget: (context, _, __) => _buildError(context),
            ),
    );
  }

  Widget _buildError(BuildContext context) {
    onError?.call();

    return errorWidget != null
        ? errorWidget!(context, url, null)
        : _defaultErrorWidget();
  }

  Widget _defaultErrorWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Icon(
        DSIcons.file_image_broken_outline,
        color: style.isLightBubbleBackground(align)
            ? DSColors.neutralMediumElephant
            : DSColors.neutralMediumCloud,
        size: 75,
      ),
    );
  }
}
