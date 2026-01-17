import 'package:flutter/material.dart';

enum BadgeVariant { defaultVariant, secondary, destructive, outline }

class CustomBadge extends StatelessWidget {
  final String label;
  final BadgeVariant variant;
  final Color? color;

  const CustomBadge({
    super.key,
    required this.label,
    this.color,
    this.variant = BadgeVariant.defaultVariant,
  });

  @override
  Widget build(BuildContext context) {
    final style = _getBadgeStyle();

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 2), // px-2.5 py-0.5
      decoration: BoxDecoration(
        color: color ?? style.backgroundColor,
        borderRadius: BorderRadius.circular(
            20), // rounded-full (often used) or rounded-md
        border: style.borderColor != null
            ? Border.all(color: style.borderColor!)
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: style.foregroundColor,
          fontSize: 12, // text-xs
          fontWeight: FontWeight.w600, // font-semibold
        ),
      ),
    );
  }

  _BadgeStyle _getBadgeStyle() {
    switch (variant) {
      case BadgeVariant.secondary:
        return _BadgeStyle(
          backgroundColor: Colors.grey[200]!, // bg-secondary
          foregroundColor: Colors.black, // text-secondary-foreground
        );
      case BadgeVariant.destructive:
        return _BadgeStyle(
          backgroundColor: Colors.red, // bg-destructive
          foregroundColor: Colors.white, // text-destructive-foreground
        );
      case BadgeVariant.outline:
        return _BadgeStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black, // text-foreground
          borderColor: Colors.black, // text-foreground
        );
      case BadgeVariant.defaultVariant:
        return _BadgeStyle(
          backgroundColor: const Color(0xFF4ADE80), // bg-[#4ade80] (primary)
          foregroundColor: Colors.white, // text-primary-foreground
        );
    }
  }
}

class _BadgeStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  _BadgeStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
  });
}
