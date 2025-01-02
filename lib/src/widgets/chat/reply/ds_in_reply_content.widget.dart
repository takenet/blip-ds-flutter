import 'package:flutter/widgets.dart';

class DSInReplyContent extends StatelessWidget {
  const DSInReplyContent({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
  });

  final Widget child;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: child,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
