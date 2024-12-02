import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../utils/ds_utils.util.dart';
import '../texts/ds_text.widget.dart';
import 'ds_svg.widget.dart';

class DSUserAvatar extends StatelessWidget {
  final String? text;
  final Uri? uri;
  final Uint8List? file;
  final double radius;
  final Color backgroundColor;
  final TextStyle textStyle;

  static const _defaultTextStyle = DSBodyTextStyle(
    color: DSColors.neutralDarkCity,
    overflow: TextOverflow.clip,
  );

  DSUserAvatar({
    super.key,
    this.text,
    this.uri,
    this.file,
    this.radius = 25.0,
    this.backgroundColor = DSColors.primaryGreensTrue,
    TextStyle textStyle = _defaultTextStyle,
  }) : textStyle = textStyle.copyWith(
          color: textStyle.color ?? _defaultTextStyle.color,
          overflow: _defaultTextStyle.overflow,
        );

  @override
  Widget build(BuildContext context) => file != null
      ? CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          backgroundImage: MemoryImage(file!),
        )
      : uri != null
          ? CachedNetworkImage(
              imageUrl: uri.toString(),
              useOldImageOnUrlChange: true,
              imageBuilder: (_, image) => CircleAvatar(
                radius: radius,
                backgroundColor: backgroundColor,
                backgroundImage: image,
              ),
              progressIndicatorBuilder: (_, __, downloadProgress) {
                final size = Size.fromRadius(radius);

                return SizedBox(
                  height: size.height,
                  width: size.width,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 1,
                  ),
                );
              },
              errorWidget: (_, __, ___) => _defaultUserIcon,
            )
          : _defaultUserIcon;

  String get _initials {
    String initials = '';

    if (text?.isNotEmpty ?? false) {
      initials = RegExp('${text!.split(' ').length >= 2 ? '\\b' : ''}[A-Za-z]')
          .allMatches(text!)
          .map((m) => m.group(0))
          .join()
          .toUpperCase();

      if (initials.isNotEmpty) {
        initials = initials.substring(0, initials.length >= 2 ? 2 : 1);
      }
    }

    return initials;
  }

  CircleAvatar get _defaultUserIcon => (text?.isNotEmpty ?? false)
      ? CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: _initials.isNotEmpty
                ? DSText(
                    _initials,
                    style: textStyle,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )
                : const Icon(
                    DSIcons.user_default_outline,
                    color: DSColors.neutralLightSnow,
                    size: 20.0,
                  ),
          ),
        )
      : CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          child: DSSvg.asset(
            'assets/svg/avatar-default.svg',
            package: DSUtils.packageName,
          ),
        );
}
