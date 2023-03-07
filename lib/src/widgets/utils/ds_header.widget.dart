// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_headline_small_text_style.theme.dart';
import '../../themes/texts/styles/ds_text_style.theme.dart';
import '../../widgets/texts/ds_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import 'ds_user_avatar.widget.dart';

class DSHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final String? customerName;
  final Uri? customerUri;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? canPop;
  final void Function()? onBackButtonPressed;
  final DSTextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final double? elevation;
  final void Function()? onTap;
  final Color backgroundColor;
  final Color color;
  late final bool isBackgroundLight;

  DSHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.customerName,
    this.customerUri,
    this.actions,
    this.leading,
    this.canPop,
    this.onBackButtonPressed,
    this.titleTextStyle,
    this.systemUiOverlayStyle,
    this.elevation = 0.0,
    this.onTap,
    this.backgroundColor = DSColors.neutralLightSnow,
    this.color = DSColors.neutralMediumWave,
  }) : super(key: key) {
    isBackgroundLight = backgroundColor.computeLuminance() > 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: color,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: elevation,
          backgroundColor: backgroundColor,
          shadowColor: DSColors.neutralMediumWave,
          actions: actions,
          titleSpacing: 0,
          leadingWidth: 40.0,
          leading: _buildLeading(context),
          title: _buildTitle(context),
          systemOverlayStyle: systemUiOverlayStyle,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56.0);

  Widget _buildTitle(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding:
          _canPop(context) ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
      leading: customerName != null || customerUri != null
          ? DSUserAvatar(
              text: customerName,
              uri: customerUri,
              radius: 20.0,
              textColor: isBackgroundLight
                  ? DSColors.neutralLightSnow
                  : DSColors.neutralDarkCity,
            )
          : null,
      title: DSText(
        title,
        style: titleTextStyle ??
            DSHeadlineSmallTextStyle(
              color: isBackgroundLight
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
            ),
      ),
      subtitle: subtitle != null
          ? DSCaptionText(
              subtitle!,
              color: isBackgroundLight
                  ? DSColors.neutralDarkCity
                  : DSColors.neutralLightSnow,
            )
          : null,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    return leading ??
        (_canPop(context)
            ? IconButton(
                splashRadius: 17,
                padding: EdgeInsets.zero,
                onPressed: onBackButtonPressed ?? Navigator.of(context).pop,
                iconSize: 28,
                icon: Icon(
                  DSIcons.arrow_left_outline,
                  color: isBackgroundLight
                      ? DSColors.neutralDarkRooftop
                      : DSColors.neutralLightSnow,
                ),
              )
            : null);
  }

  bool _canPop(BuildContext context) =>
      onBackButtonPressed != null || (canPop ?? Navigator.of(context).canPop());
}
