import 'package:flutter/material.dart';

enum AlertVariant { defaultVariant, destructive }

class CustomAlert extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? description;
  final AlertVariant variant;

  const CustomAlert({
    super.key,
    this.icon,
    this.title,
    this.description,
    this.variant = AlertVariant.defaultVariant,
  });

  @override
  Widget build(BuildContext context) {
    final style = _getAlertStyle();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: style.backgroundColor, // bg-card
        borderRadius: BorderRadius.circular(8), // rounded-lg
        border: Border.all(color: style.borderColor), // border
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(
                size: 16, // size-4
                color: style.iconColor,
              ),
              child: icon!,
            ),
            const SizedBox(width: 12), // gap-x-3
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 2), // gap-y-0.5 approx
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontSize: 14, // text-sm
                        fontWeight: FontWeight.w500, // font-medium
                        color: style.titleColor,
                        height: 1.2,
                      ),
                    ),
                  ),
                if (description != null)
                  Text(
                    description!,
                    style: TextStyle(
                      fontSize: 14, // text-sm
                      color: style.descriptionColor, // text-muted-foreground
                      height: 1.5, // leading-relaxed
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _AlertStyle _getAlertStyle() {
    switch (variant) {
      case AlertVariant.destructive:
        return _AlertStyle(
          backgroundColor: Colors.white, // bg-card (presumed white/dark)
          borderColor:
              Colors.red, // border-destructive (usually) or normal border
          titleColor: Colors.red, // text-destructive
          descriptionColor: Colors.red.withOpacity(0.9), // text-destructive/90
          iconColor: Colors.red, // text-current -> text-destructive
        );
      case AlertVariant.defaultVariant:
        return _AlertStyle(
          backgroundColor: Colors.white, // bg-card
          borderColor: Colors.grey[300]!, // border
          titleColor: Colors.black, // text-card-foreground
          descriptionColor: Colors.grey[600]!, // text-muted-foreground
          iconColor: Colors.black, // text-current
        );
    }
  }
}

class _AlertStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color descriptionColor;
  final Color iconColor;

  _AlertStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.descriptionColor,
    required this.iconColor,
  });
}
