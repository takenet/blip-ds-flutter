import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DSHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final String? customerName;
  final Uri? customerUri;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? canPop;

  const DSHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.customerName,
    this.customerUri,
    this.actions,
    this.leading,
    this.canPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarOpacity: 0.1,
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 1,
      backgroundColor: DSColors.neutralLightSnow,
      shadowColor: DSColors.neutralMediumWave,
      actions: actions,
      leadingWidth: 25.0,
      leading: _buildLeading(context),
      title: _buildTitle(),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56.0);

  Widget _buildTitle() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: customerName != null || customerUri != null
          ? DSUserAvatar(
              text: customerName,
              uri: customerUri,
              radius: 20.0,
              textColor: DSColors.neutralLightSnow,
            )
          : null,
      title: DSHeadlineSmallText(
        title,
        color: DSColors.neutralDarkCity,
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
        (canPop ?? Navigator.of(context).canPop()
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).pop(),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SvgPicture.asset(
                    'assets/images/arrow_back.svg',
                    color: DSColors.neutralDarkRooftop,
                    package: DSUtils.packageName,
                    height: 16.0,
                  ),
                ),
              )
            : null);
  }
}
