import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';

class DSProgressBar extends StatelessWidget {
  final double width;
  final double value;

  const DSProgressBar({
    super.key,
    required this.width,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(1.5),
      height: 17.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: DSColors.neutralDarkEclipse,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            width: width * value / 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: DSColors.primaryMain,
            ),
            child: AnimatedBarWidget(
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBarWidget extends StatefulWidget {
  final double width;

  const AnimatedBarWidget({
    super.key,
    required this.width,
  });

  @override
  State<AnimatedBarWidget> createState() => _AnimatedBarWidgetState();
}

class _AnimatedBarWidgetState extends State<AnimatedBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      children: List<Widget>.generate(
        widget.width ~/ 5,
        (_) => SlideTransition(
          textDirection: TextDirection.rtl,
          position: slideAnimation,
          child: Text(
            '/',
            style: TextStyle(
              color: Colors.black.withOpacity(0.2),
              fontSize: 14.0,
              height: 1.0,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
