import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final double? borderRadius;
  final Color? borderColor;
  final EdgeInsets? padding;
  final List<Widget> children;
  final bool isVertical;
  const CardWidget({
    super.key,
    required this.children,
    this.isVertical = true,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.borderRadius,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 2),
        child: isVertical
            ? Column(
                mainAxisAlignment:
                    mainAxisAlignment ?? MainAxisAlignment.center,
                crossAxisAlignment:
                    crossAxisAlignment ?? CrossAxisAlignment.center,
                mainAxisSize: mainAxisSize ?? MainAxisSize.min,
                children: children,
              )
            : Row(
                mainAxisAlignment:
                    mainAxisAlignment ?? MainAxisAlignment.center,
                crossAxisAlignment:
                    crossAxisAlignment ?? CrossAxisAlignment.center,
                mainAxisSize: mainAxisSize ?? MainAxisSize.min,
                children: children,
              ),
      ),
    );
  }
}
