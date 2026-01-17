import 'package:flutter/material.dart';

enum ButtonVariant {
  defaultVariant,
  destructive,
  outline,
  secondary,
  ghost,
  link
}

enum ButtonSize { defaultSize, sm, lg, icon }

class CustomButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool disabled;
  final double? width;

  const CustomButton({
    super.key,
    this.label,
    this.onPressed,
    this.variant = ButtonVariant.defaultVariant,
    this.size = ButtonSize.defaultSize,
    this.icon,
    this.isLoading = false,
    this.disabled = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (size == ButtonSize.icon ? 36 : null),
      height: _getHeight(),
      child: _buildButton(context),
    );
  }

  Widget _buildButton(BuildContext context) {
    if (variant == ButtonVariant.link) {
      return TextButton(
        onPressed: (disabled || isLoading) ? null : onPressed,
        style: TextButton.styleFrom(
          padding: _getPadding(),
          foregroundColor: Theme.of(context).colorScheme.primary,
          textStyle: const TextStyle(decoration: TextDecoration.underline),
        ),
        child: _buildContent(),
      );
    }

    final style = _getButtonStyle(context);

    return ElevatedButton(
      onPressed: (disabled || isLoading) ? null : onPressed,
      style: style,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    }

    final children = <Widget>[];
    if (icon != null) {
      children.add(icon!);
      if (label != null) children.add(const SizedBox(width: 8));
    }
    if (label != null) {
      children.add(Text(label!));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.sm:
        return 32;
      case ButtonSize.lg:
        return 40;
      case ButtonSize.icon:
        return 36;
      case ButtonSize.defaultSize:
        return 36;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 24);
      case ButtonSize.icon:
        return EdgeInsets.zero;
      case ButtonSize.defaultSize:
        return const EdgeInsets.symmetric(horizontal: 16);
    }
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    Color? borderColor; // borderColor is nullable

    // Colors matching React implementation
    switch (variant) {
      case ButtonVariant.destructive:
        backgroundColor = Colors.red; // tailwind destructive
        foregroundColor = Colors.white;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = Colors.black; // text-foreground
        borderColor = Colors.grey[300]; // border-input
        break;
      case ButtonVariant.secondary:
        backgroundColor = Colors.grey[200]!; // bg-secondary
        foregroundColor = Colors.black; // text-secondary-foreground
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = Colors.black;
        break;
      case ButtonVariant.defaultVariant:
      default:
        backgroundColor = const Color(0xFF4ADE80); // bg-[#4ade80]
        foregroundColor = Colors.white;
        break;
    }

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shadowColor:
          (variant == ButtonVariant.ghost || variant == ButtonVariant.outline)
              ? Colors.transparent
              : null,
      elevation:
          (variant == ButtonVariant.ghost || variant == ButtonVariant.outline)
              ? 0
              : 2,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // rounded-md
        side: borderColor != null
            ? BorderSide(color: borderColor)
            : BorderSide.none,
      ),
    );
  }
}
