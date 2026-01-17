import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? header;
  final Widget? title;
  final Widget? description;
  final Widget? content;
  final Widget? footer;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Widget? child;
  final bool isGlass;
  final double blurSigma;
  final Color? borderColor;

  const CustomCard({
    super.key,
    this.header,
    this.title,
    this.description,
    this.content,
    this.footer,
    this.padding = const EdgeInsets.all(12.0),
    this.backgroundColor,
    this.child,
    this.isGlass = false,
    this.blurSigma = 10.0,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isGlass
                ? Colors.purple.shade900.withOpacity(0.5)
                : Colors.white.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: borderColor ??
                (isGlass
                    ? Colors.white.withOpacity(0.1)
                    : Colors.white.withOpacity(0.3))),
        boxShadow: [
          if (!isGlass)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 8),
              blurRadius: 32,
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null || title != null || description != null)
              Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (header != null) ...[
                      header!,
                      const SizedBox(height: 6),
                    ],
                    if (title != null)
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isGlass ? Colors.white : Colors.black, // foreground
                          height: 1.0,
                        ),
                        child: title!,
                      ),
                    if (description != null) ...[
                      const SizedBox(height: 6),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 14,
                          color: isGlass ? Colors.white70 : Colors.grey[600], // muted-foreground
                        ),
                        child: description!,
                      ),
                    ],
                  ],
                ),
              ),
            if (content != null || child != null)
              Padding(
                padding: (content != null || child != null) &&
                        (header == null && title == null)
                    ? padding
                    : const EdgeInsets.symmetric(horizontal: 24, vertical: 6)
                        .copyWith(bottom: footer == null ? 24 : 6),
                child: content ?? child,
              ),
            if (footer != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 24),
                child: footer,
              ),
          ],
        ),
      ),
    );

    if (isGlass) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
