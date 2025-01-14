import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';
import '../../themes/texts/styles/ds_body_text_style.theme.dart';
import '../../themes/texts/styles/ds_headline_small_text_style.theme.dart';

class DSTabBar extends StatelessWidget {
  final TabController? controller;
  final Function(int)? onTap;
  final List<Widget> tabs;

  const DSTabBar({
    required this.tabs,
    super.key,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => TabBar(
        tabs: tabs,
        controller: controller,
        onTap: onTap,
        labelStyle: const DSHeadlineSmallTextStyle(
          color: DSColors.primaryNight,
        ),
        unselectedLabelStyle: const DSBodyTextStyle(
          color: DSColors.neutralDarkCity,
        ),
        dividerColor: DSColors.neutralMediumWave,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 0.0,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3.0,
            color: DSColors.primaryDark,
          ),
        ),
      );
}
