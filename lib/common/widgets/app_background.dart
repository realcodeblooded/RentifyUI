import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/app_background.png',
            fit: BoxFit.cover,
          ),
          // Overlay
          Container(
            color: Colors.black.withOpacity(0.1),
          ),
          // Child Content
          child,
        ],
      ),
    );
  }
}
