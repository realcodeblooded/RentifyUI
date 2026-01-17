import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool enabled;

  const CustomInput({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.errorText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          enabled: enabled,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black, // file:text-foreground
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500], // placeholder:text-muted-foreground
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, // px-3
              vertical: 8, // py-1 (approx for h-9)
            ),
            isDense: true,
            filled: true,
            fillColor: Colors.transparent, // bg-transparent
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6), // rounded-md
              borderSide: BorderSide(
                color: Colors.grey[300]!, // border-input
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Colors.black, // ring-ring (approx)
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Colors.red, // border-destructive
              ),
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
