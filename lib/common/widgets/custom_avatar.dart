import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final ImageProvider? image;
  final String? fallbackText;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomAvatar({
    super.key,
    this.image,
    this.fallbackText,
    this.size = 40.0, // size-10 = 2.5rem = 40px
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200], // bg-muted
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: image != null
          ? Image(
              image: image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildFallback(),
            )
          : _buildFallback(),
    );
  }

  Widget _buildFallback() {
    return Center(
      child: Text(
        fallbackText ?? '',
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? Colors.grey[600],
        ),
      ),
    );
  }
}
