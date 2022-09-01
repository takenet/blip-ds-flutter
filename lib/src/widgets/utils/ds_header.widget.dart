import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DSHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final String? customerName;
  final List<Widget>? actions;
  final Widget? leading;

  const DSHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.customerName,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: DSColors.neutralLightSnow,
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
      leading: customerName != null
          ? DSUserAvatar(
              text: customerName!,
              radius: 20.0,
              textColor: DSColors.neutralLightSnow,
            )
          : null,
      title: DSHeadlineSmallText(
        color: DSColors.neutralDarkCity,
        text: title,
      ),
      subtitle: subtitle != null
          ? DSCaptionText(
              text: subtitle!,
              color: DSColors.neutralDarkCity,
            )
          : null,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    final bool canPop = Navigator.of(context).canPop();

    return leading ??
        (canPop
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).pop(),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SvgPicture.asset(
                    'assets/images/arrow_back.svg',
                    color: DSColors.neutralDarkRooftop,
                    package: DSUtils.packageName,
                    height: 18.0,
                  ),
                ),
              )
            : null);
  }
}
