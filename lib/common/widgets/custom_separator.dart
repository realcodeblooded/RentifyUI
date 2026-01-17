import 'package:flutter/material.dart';

class CustomSeparator extends StatelessWidget {
  final Axis orientation;
  final Color? color;
  final double thickness;
  final double? height;
  final double? width;

  const CustomSeparator({
    super.key,
    this.orientation = Axis.horizontal,
    this.color,
    this.thickness = 1.0,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Colors.grey[300]; // bg-border

    if (orientation == Axis.horizontal) {
      return SizedBox(
        width: width ?? double.infinity,
        height: thickness,
        child: DecoratedBox(
          decoration: BoxDecoration(color: effectiveColor),
        ),
      );
    } else {
      return SizedBox(
        width: thickness,
        height: height ?? double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(color: effectiveColor),
        ),
      );
    }
  }
}
