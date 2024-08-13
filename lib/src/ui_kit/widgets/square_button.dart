import 'package:flutter/material.dart';

import '../ui_kit.dart';

class SquareButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final double ?size;
  final Color? borderColor;
  const SquareButton({
    super.key,
    required this.child,
    this.borderColor,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? AppColors.grey,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding:  EdgeInsets.all( size ??2.0),
          child: child,
        ),
      ),
    );
  }
}
