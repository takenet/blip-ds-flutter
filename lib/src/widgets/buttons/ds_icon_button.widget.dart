import 'package:flutter/material.dart';

const size = Size(44, 44);

class DSIconButton extends InkWell {
  DSIconButton({
    super.key,
    required void Function() onPressed,
    required Widget icon,
  }) : super(
          onTap: onPressed,
          child: SizedBox.fromSize(
            size: size,
            child: Center(
              child: icon,
            ),
          ),
        );
}
