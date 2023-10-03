import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../enums/ds_align.enum.dart';
import '../../models/ds_message_bubble_style.model.dart';
import '../../services/ds_auth.service.dart';
import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';

class DSCachedNetworkImageView extends StatelessWidget {
  final String url;
  final DSAlign align;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final void Function()? onError;
  final DSMessageBubbleStyle style;
  final bool shouldAuthenticate;

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
    required this.align,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.onError,
    this.shouldAuthenticate = false,
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
              httpHeaders:
                  shouldAuthenticate ? DSAuthService.httpHeaders : null,
              placeholder: placeholder,
              errorWidget: (context, error, __) => _buildError(context),
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
