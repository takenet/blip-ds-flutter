import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_text_style.theme.dart';
import '../../themes/texts/styles/ds_headline_small_text_style.theme.dart';
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

  const DSHeader({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 1,
      backgroundColor: DSColors.neutralLightSnow,
      shadowColor: DSColors.neutralMediumWave,
      actions: actions,
      titleSpacing: 0,
      leadingWidth: 40.0,
      leading: _buildLeading(context),
      title: _buildTitle(context),
      systemOverlayStyle: systemUiOverlayStyle,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56.0);

  Widget _buildTitle(BuildContext context) {
    return ListTile(
      contentPadding:
          _canPop(context) ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
      leading: customerName != null || customerUri != null
          ? DSUserAvatar(
              text: customerName,
              uri: customerUri,
              radius: 20.0,
              textColor: DSColors.neutralLightSnow,
            )
          : null,
      title: DSText(
        title,
        style: titleTextStyle ??
            const DSHeadlineSmallTextStyle(
              color: DSColors.neutralDarkCity,
            ),
      ),
      subtitle: subtitle != null
          ? DSCaptionText(
              subtitle!,
              color: DSColors.neutralDarkCity,
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
                icon: const Icon(
                  DSIcons.arrow_left_outline,
                  color: DSColors.neutralDarkRooftop,
                ),
              )
            : null);
  }

  bool _canPop(BuildContext context) =>
      onBackButtonPressed != null || (canPop ?? Navigator.of(context).canPop());
}
