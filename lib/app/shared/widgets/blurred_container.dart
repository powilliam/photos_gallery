import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredContainer extends StatelessWidget {
  BlurredContainer({Key key, this.padding, this.child}) : super(key: key);

  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          constraints: BoxConstraints(minHeight: 48),
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          color: Colors.black.withOpacity(0.12),
          child: child,
        ),
      ),
    );
  }
}
