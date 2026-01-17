import 'package:flutter/material.dart';

class CustomSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? color;

  const CustomSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 6.0, // rounded-md
    this.color,
  });

  @override
  State<CustomSkeleton> createState() => _CustomSkeletonState();
}

class _CustomSkeletonState extends State<CustomSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color ?? Colors.grey[200], // bg-accent
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }
}
