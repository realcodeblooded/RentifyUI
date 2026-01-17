import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  final double value;
  final double height;
  final Color? color;
  final Color? backgroundColor;

  /// [value] must be between 0.0 and 1.0
  const CustomProgress({
    super.key,
    required this.value,
    this.height = 8.0,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        color: color ?? Colors.black,
        backgroundColor: backgroundColor ?? Colors.grey[200],
      ),
    );
  }
}
