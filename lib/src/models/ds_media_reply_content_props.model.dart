import 'package:flutter/widgets.dart';

class DSMediaReplyContentProps {
  String mediaTextTranslateKey;
  IconData mediaIcon;
  Widget trailing;
  double size;
  String title;
  Widget? subtitle;

  DSMediaReplyContentProps({
    required this.mediaTextTranslateKey,
    required this.mediaIcon,
    this.title = '',
    this.trailing = const SizedBox.shrink(),
    this.size = 0.0,
    this.subtitle,
  });
}
