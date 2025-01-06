import 'package:flutter/material.dart';

import '../../controllers/chat/ds_highlight.controller.dart';

class DSHighlight extends StatefulWidget {
  final Widget child;
  final DSHighlightController controller;

  const DSHighlight({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DSHighlight> createState() => _DSTesteState();
}

class _DSTesteState extends State<DSHighlight> with TickerProviderStateMixin {
  late AnimationController? animationController;

  @override
  void initState() {
    animationController =
        widget.controller.getController(widget.key.toString());

    if (animationController == null) {
      animationController = AnimationController(vsync: this);
      widget.controller.add(widget.key.toString(), animationController!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBoxTransition(
      decoration: DecorationTween(
        begin: BoxDecoration(),
        end: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.1),
        ),
      ).animate(animationController!),
      child: widget.child,
    );
  }
}
