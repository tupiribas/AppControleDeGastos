import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final Widget widget;
  final Function onPressed;

  const AdaptativeButton({
    Key? key,
    required this.widget,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: () => onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: widget,
          )
        : ElevatedButton(onPressed: () => onPressed, child: widget);
  }
}
